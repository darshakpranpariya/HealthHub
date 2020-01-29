from flask import Flask,request,jsonify
import requests
app = Flask(__name__)

@app.route("/api",methods = ['GET'])
def home():
	d = {}
	ans = []
	f = {}
	text = str(request.args['text'])
	ans = requests.post("https://bern.korea.ac.kr/plain", data={'sample_text': text}).json()['denotations']
	for i in range(0,len(ans)):
		s=""
		b = ans[i]['span']['begin']
		e = ans[i]['span']['end']
		for j in range(b,e):
			s+=text[j]
		typee = ans[i]['obj']
		f[s] = typee
	return jsonify((f))
    
@app.route("/salvador")
def salvador():
    return "Hello, Salvador"
    
if __name__ == "__main__":
    app.run(debug=True)