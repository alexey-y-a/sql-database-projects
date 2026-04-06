-- Задача 2: Все сотрудники под Иваном Ивановым с количеством задач и прямыми подчинёнными
WITH RECURSIVE employee_hierarchy AS (
    SELECT
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    SELECT
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
             INNER JOIN employee_hierarchy eh ON e.ManagerID = eh.EmployeeID
),
               subordinates_count AS (
                   SELECT
                       ManagerID,
                       COUNT(*) AS total_subordinates
                   FROM Employees
                   GROUP BY ManagerID
               ),
               employee_details AS (
                   SELECT
                       eh.EmployeeID,
                       eh.Name AS EmployeeName,
                       eh.ManagerID,
                       d.DepartmentName,
                       r.RoleName,
                       STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName) AS ProjectNames,
                       STRING_AGG(t.TaskName, ', ' ORDER BY t.TaskID DESC) AS TaskNames,
                       COUNT(DISTINCT t.TaskID) AS TotalTasks,
                       COALESCE(sc.total_subordinates, 0) AS TotalSubordinates
                   FROM employee_hierarchy eh
                            LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
                            LEFT JOIN Roles r ON eh.RoleID = r.RoleID
                            LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
                            LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
                            LEFT JOIN subordinates_count sc ON eh.EmployeeID = sc.ManagerID
                   GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, sc.total_subordinates
               )
SELECT
    EmployeeID,
    EmployeeName,
    ManagerID,
    DepartmentName,
    RoleName,
    ProjectNames,
    TaskNames,
    TotalTasks,
    TotalSubordinates
FROM employee_details
ORDER BY EmployeeName;