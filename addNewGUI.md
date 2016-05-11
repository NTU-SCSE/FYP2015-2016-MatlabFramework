<h2>How to add new GUI into the system</h2>

<p>If you have a GUI that is already developed follow the instructions below</p>
<h4>Instruction</h4>
<p>
Assuming that you have add new GUI with new course and topic:
<li>You have to prepare 3 xml files: 1 for Course , 1 for Topic and 1 for the Sub-Topic which is for the GUI itself</li>
<li>For example, if you want to add Computer Vision course, in the 2nd line of the xml file the <type>...</type> will be 'course' and the <course>...</course> will be the name of the course which is in this case 'Computer Vision'</li>
<li>After adding the course xml file you have to have a topic xml file let say I name it 'Decision Making', so the line <topic>...</topic> will be the name of the topic and in this xml file I have to make sure the <course>...</course> also will be 'Computer Vision'</li>
<li>Lastly, the xml file for the sub-topic, I have the GUI called SVM and I will put the <subtopic>...</subtopic> as 'SVM'. I have to make sure the <course>...</course> is 'Computer Vision' and the <topic>..</topic> is 'Decision Making' in order for this GUI to be specified correctly.</li>
<li>In the sub-topic xml file the <function>...</function>, <description>...</description> and <snapshots>...</snapshots>, you are suppose to fill in this information.</li>
</p>


