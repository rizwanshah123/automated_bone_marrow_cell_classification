


<h1>Automated Bone Marrow Cell Classification</h1>
---

<p>This project automates the classification of bone marrow cells using advanced machine learning algorithms, integrated with a Flutter-based mobile application. By leveraging deep learning techniques and a diverse dataset of labeled microscopic cell images, the system aims to achieve high-precision identification of cell types. The primary objective is to streamline hematological diagnostics, enhancing both speed and accuracy while minimizing the workload on pathologists.</p>


<h2>Features</h2>

<h3>Automated Cell Classification</h3>
<ul>
    <li><strong>AI Model:</strong> Trained using an exhaustive dataset of various cell types and morphologies.</li>
    <li><strong>Server Deployment:</strong> The AI model is deployed on a server accessible to clinical specialists.</li>
    <li><strong>Flutter Mobile App:</strong> Allows healthcare professionals to easily upload bone marrow cell images for classification.</li>
</ul>

<h3>Enhanced Diagnostic Accuracy</h3>
<ul>
    <li><strong>Reduction in Examination Time:</strong> Automates the cell classification process, significantly reducing the time required for analysis.</li>
    <li><strong>Improved Consistency:</strong> Provides consistent results, enhancing diagnostic accuracy.</li>
    <li><strong>Wide Accessibility:</strong> The mobile app facilitates broader access to hematological diagnostics, ensuring faster and more reliable patient care.</li>
</ul>

<h2>Installation</h2>
<p><strong>Clone the Repository:</strong></p>
<pre><code>
git clone https://github.com/yourusername/bone-marrow-cell-classification.git
cd bone-marrow-cell-classification
</code></pre>

<p><strong>Set up the Flask Backend:</strong></p>
<pre><code>
pip install -r requirements.txt
</code></pre>

<p><strong>Run the Flask Server:</strong></p>
<pre><code>
python app.py
</code></pre>

<p><strong>Set up the Flutter Mobile App:</strong></p>
<ul>
    <li>Navigate to the <code>flutter_app</code> folder:</li>
    <pre><code>
    cd flutter_app
    </code></pre>
    <li>Install the necessary Flutter packages:</li>
    <pre><code>
    flutter pub get
    </code></pre>
    <li>Run the Flutter app on your connected device or emulator:</li>
    <pre><code>
    flutter run
    </code></pre>
</ul>

<h2>API Endpoints</h2>

<h3>Image Upload and Classification Endpoint</h3>
<p><strong>Endpoint:</strong> /process-image</p>
<p><strong>Method:</strong> POST</p>
<p><strong>Description:</strong> Uploads a bone marrow cell image for classification and returns the predicted class along with its description.</p>
<p><strong>Example Request:</strong></p>
<pre><code>
curl -X POST -F "image=@path_to_your_image.jpg" http://localhost:5000/process-image
</code></pre>
<p><strong>Example Response:</strong></p>
<pre><code>
{
    "message": "Image processed successfully",
    "predictions": {
        "MYB": "Myeloblast: Precursor cell of granulocytes and monocytes...",
        "PLM": "Plasma cell: Mature antibody-secreting cell of the B lymphocyte lineage..."
    }
}
</code></pre>

<h2>Project Structure</h2>
<ul>
    <li><strong>app.py:</strong> Main Flask application file.</li>
    <li><strong>model.py:</strong> Contains the code for the trained AI model.</li>
    <li><strong>requirements.txt:</strong> List of dependencies required for the project.</li>
    <li><strong>flutter_app/:</strong> Folder containing the Flutter mobile app.</li>
</ul>

<h2>Contributing</h2>
<p>Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.</p>

<h2>License</h2>
<p>This project is licensed under the MIT License. See the LICENSE file for more details.</p>

<h2>Contact</h2>
<p>For any questions or issues, please open an issue in this repository or contact me at <a href="mailto:shahrizwan403@gmail.com">shahrizwan403@gmail.com</a>.</p>
