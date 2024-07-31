from flask import Flask, request, jsonify
from flask_restful import Api, Resource
from tensorflow.keras.models import load_model
import numpy as np
from PIL import Image

app = Flask(__name__)
api = Api(app)

model_path = 'best_model.h5'

cell_descriptions = {
    'other': 'The "Other" class encompasses items that do not fall into the predefined categories within the model, particularly those that are not classified as "cell."',
    'PLM': 'Plasma cell: Mature antibody-secreting cell of the B lymphocyte lineage. Plasma cells play a crucial role in humoral immunity by producing and secreting antibodies (immunoglobulins) to fight against pathogens.',
    'PMO': 'Promonocyte: Immature precursor of a monocyte. Promonocytes differentiate into monocytes, which are a type of phagocytic white blood cell involved in the immune response and inflammation.',
    'EBO': 'Erythroblast: Immature red blood cell precursor. Erythroblasts are committed to the erythroid lineage and undergo a series of maturation steps to become mature red blood cells (erythrocytes), which transport oxygen throughout the body.',
    'BLA': 'Blast: Immature precursor cell that gives rise to other cell types. Blast cells are undifferentiated and have the potential to differentiate into various specialized cell types depending on the signals they receive from their microenvironment.',
    'NGS': 'Neutrophilic granulocyte: Phagocytic white blood cell with granules containing enzymes. Neutrophils are the most abundant type of white blood cell and play a critical role in the innate immune response against bacterial and fungal infections.',
    'MYB': 'Myeloblast: Precursor cell of granulocytes and monocytes. Myeloblasts give rise to neutrophils, eosinophils, basophils, and monocytes in the bone marrow. They are part of the myeloid lineage of hematopoietic cells.',
    'ART': 'Artefact: Cell that appears in bone marrow samples due to processing or staining artifacts. Artefacts are non-cellular structures or staining artifacts that may be mistakenly interpreted as cells during microscopic examination.',
    'LYT': 'Lytic cell: Cell undergoing lysis or destruction. Lytic cells may represent damaged or dying cells undergoing cell death processes such as apoptosis or necrosis. They can release cellular contents and trigger inflammatory responses.',
    'NGB': 'Nongranular leukocyte : White blood cell without granules in the cytoplasm. Nongranular leukocytes include lymphocytes and monocytes, which lack visible cytoplasmic granules under light microscopy. They play diverse roles in immune surveillance and response.'
}
class ImageProcessing(Resource):
    def __init__(self):
        super(ImageProcessing, self).__init__()
        self.model = load_model(model_path)

    def post(self):
        try:
            uploaded_image = request.files['image']
            img = Image.open(uploaded_image)
            img = img.resize((250, 250))
            img_array = np.array(img) / 255.0
            img_array = np.expand_dims(img_array, axis=0)
            predictions = self.model.predict(img_array)
            class_labels = ['MYB', 'PMO', 'LYT', 'other', 'EBO', 'NGB', 'PLM', 'BLA', 'ART', 'NGS']
            predicted_classes = [class_labels[i] for i in np.argmax(predictions, axis=1)]

            # Modify the response to include only the predicted classes and their descriptions
            response = {"message": "Image processed successfully", "predictions": {}}
            for predicted_class in predicted_classes:
                response["predictions"][predicted_class] = cell_descriptions.get(predicted_class, "Description not available")

        except Exception as e:
            response = {"error": f"${e}"}
        finally:
            print(response)
            return jsonify(response)

api.add_resource(ImageProcessing, '/process-image')

if __name__ == '__main__':
    app.run('0.0.0.0',debug=True)
