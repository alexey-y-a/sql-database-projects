-- Задача 3: Менеджеры, у которых есть подчинённые (включая всех подчинённых рекурсивно)
WITH RECURSIVE subordinates_tree AS (
    SELECT
        ManagerID,
        EmployeeID
    FROM Employees
    WHERE ManagerID IS NOT NULL

    UNION ALL

    SELECT
        st.ManagerID,
        e.EmployeeID
    FROM Employees e
             INNER JOIN subordinates_tree st ON e.ManagerID = st.EmployeeID
),
               all_subordinates_count AS (
                   SELECT
                       ManagerID,
                       COUNT(*) AS total_subordinates
                   FROM subordinates_tree
                   GROUP BY ManagerID
               ),
               employee_details AS (
                   SELECT
                       e.EmployeeID,
                       e.Name AS EmployeeName,
                       e.ManagerID,
                       d.DepartmentName,
                       r.RoleName,
                       STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName) AS ProjectNames,
                       STRING_AGG(t.TaskName, ', ' ORDER BY t.TaskID DESC) AS TaskNames,
                       COALESCE(asc_total.total_subordinates, 0) AS TotalSubordinates
                   FROM Employees e
                            LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
                            LEFT JOIN Roles r ON e.RoleID = r.RoleID
                            LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
                            LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
                            LEFT JOIN all_subordinates_count asc_total ON e.EmployeeID = asc_total.ManagerID
                   WHERE r.RoleName = 'Менеджер'
                     AND asc_total.total_subordinates > 0
                   GROUP BY e.EmployeeID, e.Name, e.ManagerID, d.DepartmentName, r.RoleName, asc_total.total_subordinates
               )
SELECT
    EmployeeID,
    EmployeeName,
    ManagerID,
    DepartmentName,
    RoleName,
    ProjectNames,
    TaskNames,
    TotalSubordinates
FROM employee_details
ORDER BY EmployeeName;