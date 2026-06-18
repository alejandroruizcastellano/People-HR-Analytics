SELECT
	e.emp_no,
    concat(e.first_name," ", e.last_name) as empleado,
    e.hire_date as fecha_contrato,
	CASE 
		WHEN gender = 'M' then 'Masculino'
        WHEN gender = 'F' then 'Femenino'
        ELSE "Otro"
	END as genero,
    e.birth_date as fecha_nacimiento,
    e.education as grado_academico,
    ti.title as cargo,
    dp.dept_name as departamento,
    ti.from_date as cargo_desde,
	# Veo que la tabla title cuando el cargo es que acutalmente ocupa aparece la constante '9999-01-01', por lo que sustituyo ese valor por la fecha actual
    # IF(ti.to_date = '9999-01-01', CURDATE(), ti.to_date) as cargo_hasta,
     ti.to_date as cargo_hasta,
    ct.city_name as ubicacion, 
    co.name as pais
FROM employees e
	LEFT JOIN titles ti ON ti.emp_no = e.emp_no
    LEFT JOIN dept_emp demp ON demp.emp_no = e.emp_no
    LEFT JOIN departments dp ON dp.dept_no = demp.dept_no 
    LEFT JOIN cities ct ON ct.city_no = e.city
    LEFT JOIN country co ON co.country_no = ct.country_no