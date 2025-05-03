<!DOCTYPE html>
<html>

<head>
    <title>Student & Course Portal</title>
</head>

<body style="margin: 0; padding: 0; background: linear-gradient(120deg, #f8fafc, #e2e8f0); font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #333;">
    <div style="max-width: 960px; margin: auto; padding: 50px 20px;">
        <header style="text-align: center; margin-bottom: 40px;">
            <h1 style="font-size: 2.5rem; margin-bottom: 10px; color: #2c5282;">🎓 Student & Course Portal</h1>
            <p style="font-size: 1.1rem; color: #4a5568;">Powered by Laravel, Docker, and a ton of coffee</p>
        </header>

        <div style="display: flex; justify-content: center; gap: 20px; margin-bottom: 30px;">
            <button onclick="fetchStudents()" style="background-color: #2b6cb0; color: white; border: none; padding: 12px 25px; font-size: 16px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
                📘 Students
            </button>
            <button onclick="fetchSubjects()" style="background-color: #38a169; color: white; border: none; padding: 12px 25px; font-size: 16px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
                📚 Courses
            </button>
        </div>

        <div id="nodeInfo" style="text-align: center; margin-bottom: 20px; font-weight: bold;">
            🖥️ Responding Node: <span id="nodeId" style="color: #805ad5;">Loading...</span>
        </div>

        <div id="content" style="background: white; border-radius: 8px; padding: 30px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);">
            <p style="text-align: center; color: #718096;">Click on a button above to view data.</p>
        </div>

        <footer style="text-align: center; margin-top: 50px; font-size: 0.9rem; color: #a0aec0;">
            &copy; {{ date('Y') }} University of Dodoma | CS 421 - App Deployment
        </footer>
    </div>

    <script>
        function fetchStudents() {
            const contentDiv = document.getElementById('content');
            contentDiv.innerHTML = '<p style="text-align:center; color:#4a5568;">Loading students...</p>';

            fetch('/api/students')
                .then(response => {
                    updateNodeId(response.headers.get('X-Node-ID'));
                    return response.json();
                })
                .then(data => {
                    let html = '<h2 style="color:#2b6cb0; margin-bottom:15px;">👥 Students List</h2>';
                    html += '<ul style="list-style: none; padding-left: 0;">';
                    data.slice(0, 10).forEach(student => {
                        html += `<li style="margin-bottom: 12px; padding: 10px; background: #edf2f7; border-radius: 6px;"><strong>${student.name}</strong> - ${student.program}</li>`;
                    });
                    html += '</ul>';
                    contentDiv.innerHTML = html;
                })
                .catch(err => {
                    contentDiv.innerHTML = `<p style="color:red;">Error fetching students: ${err}</p>`;
                });
        }

        function fetchSubjects() {
            const contentDiv = document.getElementById('content');
            contentDiv.innerHTML = '<p style="text-align:center; color:#4a5568;">Loading subjects...</p>';

            fetch('/api/subjects')
                .then(response => {
                    updateNodeId(response.headers.get('X-Node-ID'));
                    return response.json();
                })
                .then(data => {
                    let html = '<h2 style="color:#38a169; margin-bottom:15px;">📚 Software Engineering Courses</h2>';
                    for (let year in data) {
                        html += `<h3 style="margin-top: 20px; color:#2d3748;">Year ${year}</h3>`;
                        html += '<ul style="margin-left: 20px; color:#4a5568;">';
                        data[year].forEach(subject => {
                            html += `<li style="margin-bottom: 6px;">${subject.name}</li>`;
                        });
                        html += '</ul>';
                    }
                    contentDiv.innerHTML = html;
                })
                .catch(err => {
                    contentDiv.innerHTML = `<p style="color:red;">Error fetching subjects: ${err}</p>`;
                });
        }

        function updateNodeId(nodeId) {
            document.getElementById('nodeId').textContent = nodeId || 'Unavailable';
        }

        // Fetch node ID on load using HEAD request
        fetch('/api/students', {
                method: 'HEAD'
            })
            .then(response => updateNodeId(response.headers.get('X-Node-ID')))
            .catch(() => updateNodeId('Unavailable'));
    </script>
</body>

</html>