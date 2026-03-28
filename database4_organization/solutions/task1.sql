-- Задача 1: Найти всех сотрудников, подчиняющихся Ивану Иванову (EmployeeID = 1)
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
               employee_details AS (
                   SELECT
                       eh.EmployeeID,
                       eh.Name AS EmployeeName,
                       eh.ManagerID,
                       d.DepartmentName,
                       r.RoleName,
                       STRING_AGG(DISTINCT p.ProjectName, ', ' ORDER BY p.ProjectName) AS ProjectNames,
                       STRING_AGG(DISTINCT t.TaskName, ', ' ORDER BY t.TaskName) AS TaskNames
                   FROM employee_hierarchy eh
                            LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
                            LEFT JOIN Roles r ON eh.RoleID = r.RoleID
                            LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
                            LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
                   GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
               )
SELECT
    EmployeeID,
    EmployeeName,
    ManagerID,
    DepartmentName,
    RoleName,
    ProjectNames,
    TaskNames
FROM employee_details
ORDER BY EmployeeName;