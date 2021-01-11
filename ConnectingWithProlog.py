import numpy as np
import pandas as pd
import nltk
from sklearn.linear_model import LogisticRegression as LR
from sklearn.feature_extraction.text import CountVectorizer
from nltk.tokenize import word_tokenize
from nltk.stem import PorterStemmer
from pyswip import Prolog

careers = ['ai','de','is','mc','ws']
name = {'ai':'Artificial Intelligence', 'de':'Data Engineering', 'is':'Information Security', 'mc':'Mobile Computing', 'ws':'Computer Science'}

swipl = Prolog()
swipl.consult("/Users/deepankar/Desktop/AI-A4-DeepankarKansal-MT20007/career.pl")
data = pd.read_csv('/Users/deepankar/Desktop/AI-A4-DeepankarKansal-MT20007/AI_Assignment4_Data.csv', header=None)
X = data.iloc[:,0].values
y = data.iloc[:,-1].values
new_X = []
# print(X)
for dt in range(X.size):
    tok1 = word_tokenize(X[dt])
    ps = PorterStemmer()
    str1 = [ps.stem(word) for word in tok1]
    str1 = ' '.join(str1)
    str1 = str1.lower()
    new_X.append(str1)
# print(new_X)
X = np.array(new_X)

# print(X.shape)
inp1 = input("What areas are you interested in? Explain in details...\n")
# # print("\nWe have got ...", inp1)
tok1 = word_tokenize(inp1)
print("\n\n...tokens are ...", tok1)
tags = nltk.pos_tag(tok1)
print("\n...Tags are ...", tags)

ps = PorterStemmer()
str1 = [ps.stem(word) for word in tok1]

str1 = ' '.join(str1)
str1 = str1.lower()
print("\n\nAfter processing your query is:",str1)
X = np.append(X, str1)

cv = CountVectorizer(max_features = 50)
X = cv.fit_transform(X).toarray()
# print(X.shape)
clf = LR()
y = y.astype('int')
clf.fit(X[:-1], y)
career = clf.predict(X[-1].reshape(1,50))


print("\n\n---------------------******************-------------------------")
print("\tYour interest is in",name[careers[career[0]]],"field\n \tSuggested careers are:")
f = open("careers.txt", 'w')
f.write("interested_in('"+name[careers[career[0]]]+"').\n")
for sol in swipl.query("suggest("+careers[career[0]]+", D)"):
    for j in sol['D']:
        print("\t\t",j)
        f.write("suggested_careers('" + str(j) + "').\n")
f.close()

""" Tested Queries
1. I have done many projects in robotics and want to pursue a career in this field only...
2. I have done my degree in Data Engineering field and I am really fascinated by Data related things.
3. I have keen interest in AI & ML
4. Information security is my field of interest and Cryptography is one of preferred field
5. I have keen interest in computer related technologies which belongs to software part
6. I would like to work in computer science field, like Compilers and Full Stack developer
7. I am more interested in general computer science field and would like to pursue a career in softwares...
8. Mobile Computing and Cloud Computing are my keen interests and I have done many projects in these fields
"""