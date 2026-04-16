<img src="./clnj3mph.png"
style="width:1.60157in;height:0.51457in" />

> **Percepción** **3D** **PRACTICA** **1**
>
> **PREPROCESAMIENTO** **Y** **SEGMENTACIÓN** **DE** **NUBES** **DE**
> **PUNTOS**

José Carlos Castillo **Arturo** **de** **la** **Escalera**

> 2022/2023
>
> <img src="./ionhbxvh.png"
> style="width:1.60157in;height:0.51457in" />**índice**

**Leer** **y** **escribir** **nubes** **de** **puntos** **Mallas**

**Preprocesamiento** **Encontrar** **un** **plano**

**Funciones** **para** **encontrar** **objetos** **Segmentación**
**por** **distancia**

> Arturo de la Escalera Percepción 3D 2
>
> <img src="./hxsbmtwa.png"
> style="width:1.60157in;height:0.51457in" />**Leer** **y** **escribir**
> **nubes** **de** **puntos**

**pcread**

Leer una nube de puntos 3-D desde un fichero en formato PLY o PCD
**pcwrite**

> Escribir una nube de puntos 3-D desde un fichero en formato PLY o PCD

**pcfromkinect**

Leer una nube de puntos 3-D desde una Kinect para Windows
**velodyneFileReader**

> Leer una nube de puntos 3-D desde un fichero en formato Velodyne PCAP
>
> Arturo de la Escalera Percepción 3D 3
>
> <img src="./d0lzl5ct.png"
> style="width:1.60157in;height:0.51457in" />**Formatos** **de**
> **ficheros**

**Formato** **“Polygon** **file”** **o** **“Stanford** **triangle”**
**(PLY)** Los objetos se describen como polígonos.

> El fichero tiene una cabecera seguida de la lista de vértices y de
> polígonos.
>
> En la cabecera se especifica: número de vértices y polígonos y la
> propiedades de los vértices: coordenadas (x,y,z), normales, y color

**Formato** **“point** **cloud** **data”** **(PCD)**

> Desarrollado para la biblioteca de funciones Point cloud library (PCL)
>
> Arturo de la Escalera Percepción 3D 4
>
> <img src="./ro0hthlc.png"
> style="width:1.60157in;height:0.51457in" />**Cargar** **archivo**
> **y** **ver** **por** **pantalla**

<img src="./1aylypiz.png"
style="width:5.68228in;height:4.90512in" />**1.** **ptCloud** **=**
**pcread('mesa.ply');** **2.** **pcshow(ptCloud);**

> Arturo de la Escalera Percepción 3D 5
>
> <img src="./xmjytlhf.png"
> style="width:1.60157in;height:0.51457in" /><img src="./ltuitpip.png"
> style="width:3.58897in;height:5.58976in" />**Propiedades** **de**
> **una** **nube** **de** **puntos**<img src="./pfyna2lj.png"
> style="width:4.36062in;height:2.98583in" />

Arturo de la Escalera Percepción 3D 6

> <img src="./qvw02edn.png"
> style="width:1.60157in;height:0.51457in" />**índice**

**Leer** **y** **escribir** **nubes** **de** **puntos** **Mallas**

**Preprocesamiento** **Encontrar** **un** **plano**

**Funciones** **para** **encontrar** **objetos** **Segmentación**
**por** **distancia**

> Arturo de la Escalera Percepción 3D 7
>
> <img src="./1vkf305c.png"
> style="width:1.60157in;height:0.51457in" />**Mallas**<img src="./42rybeug.png"
> style="width:4.35669in;height:3.73976in" /><img src="./f2qgji5z.png"
> style="width:4.35669in;height:3.73976in" />

**\>\>** **pc=pcread("esfera_ds.ply");**

**\>\>** **malla=delaunayTriangulation(pc.Location);** **\>\>**
**tetramesh(malla);**

> Arturo de la Escalera Percepción 3D 8
>
> <img src="./ug25xhdu.png"
> style="width:1.60157in;height:0.51457in" />**índice**

**Leer** **y** **escribir** **nubes** **de** **puntos** **Mallas**

**Preprocesamiento** Restringir el rango

> Variar la resolución de la nube de puntos Filtrado de puntos aislados

Obtener la normal a un punto **Encontrar** **un** **plano**

**Funciones** **para** **encontrar** **objetos** **Segmentación**
**por** **distancia**

> Arturo de la Escalera Percepción 3D 9
>
> <img src="./i5kercst.png"
> style="width:1.60157in;height:0.51457in" />**Restringir** **el**
> **rango**

**indices** **=** **findPointsInROI(ptCloud,roi)**
pc=pcread('mesa.ply');

> <img src="./o0hnokg2.png"
> style="width:4.93858in;height:3.70393in" />roi =\[
> -1,0;-0.2,0.4;-1.8,-1.2\]; indices = findPointsInROI(pc, roi); pc2 =
> select(pc,indices); pcshow(pc.Location,'r');
>
> hold on; pcshow(pc2.Location,'g'); hold off;
>
> Arturo de la Escalera Percepción 3D 10
>
> <img src="./2rl0y2o3.png"
> style="width:1.60157in;height:0.51457in" />**Variar** **la**
> **resolución** **de** **la** **nube** **de** **puntos**

**pcdownsample(ptCloudIn,'random',percentage)**

**pcdownsample(ptCloudIn,'gridAverage',gridStep)**

**pcdownsample(ptCloudIn,'nonuniformGridSample',** **maxNumPoints)**

> maxNumPoints al menos 6
>
> Arturo de la Escalera Percepción 3D 11
>
> <img src="./5zfdsl22.png"
> style="width:1.60157in;height:0.51457in" />**Variar** **la**
> **resolución** **de** **la** **nube** **de** **puntos**
>
> <img src="./4y2aiqn5.png"
> style="width:3.93661in;height:2.95236in" /><img src="./jictnvmq.png"
> style="width:3.93661in;height:2.95236in" /><img src="./umlio10a.png"
> style="width:3.93661in;height:2.95236in" /><img src="./c12dhmo2.png"
> style="width:3.93661in;height:2.95236in" />gridAverage
>
> random

Arturo de la Escalera

nonuniformGridSample

> Percepción 3D 12
>
> <img src="./vdqkm1i4.png"
> style="width:1.60157in;height:0.51457in" />**Variar** **la**
> **resolución** **de** **la** **nube** **de** **puntos**

**gridStep** **=** **0.05;**

<img src="./tmowugcw.png"
style="width:6.56614in;height:4.9244in" />**pc2=**
**pcdownsample(pc,'gridAverage',gridStep);** **pcshow(pc2);**

> Arturo de la Escalera Percepción 3D 13
>
> <img src="./qpiu53up.png"
> style="width:1.60157in;height:0.51457in" />**Eliminar** **“outliers”**

**ptCloudOut** **=** **pcdenoise(ptCloudIn)**

> Estima la media de la distancia a los k-vecinos más próximos y si es
> mayor que un valor elimina el punto
>
> NumNeighbors por defecto 4
>
> *Threshold* por defecto: 1 desviación típica de la media de todas las
> distancias

**\[ptCloudOut,inlierIndices,outlierIndices\]** **=**
**pcdenoise(ptCloudIn)**

**ptCloudOut** **=** **pcdenoise(ptCloudIn,**
**'Threshold’,TValor,'NumNeighbors’,Nvalor)**

> Arturo de la Escalera Percepción 3D 14
>
> <img src="./41nmfu2f.png"
> style="width:1.60157in;height:0.51457in" />**Eliminar** **“outliers”**
>
> <img src="./irpp4uuk.png"
> style="width:4.19921in;height:3.14921in" /><img src="./h0nuacl3.png"
> style="width:4.19921in;height:3.14921in" />pc2 = pcdenoise(pc);
>
> <img src="./aq2jukpt.png"
> style="width:4.19921in;height:3.14921in" />pc3 =
> pcdenoise(pc,'Threshold',0.5,'NumNeighbors',20);

Arturo de la Escalera Percepción 3D 15

> <img src="./bmabi4nl.png"
> style="width:1.60157in;height:0.51457in" />**Obtener** **las**
> **normales** **a** **un** **punto**

**normals** **=** **pcnormals(ptCloud)**

> Devuelve una matriz con la normal a cada uno de los puntos de la
> función.
>
> Usa seis puntos para obtener el plano local a cada punto

**normals** **=** **pcnormals(ptCloud,k)**

> Podemos usar más o menos puntos para obtener el plano
>
> Arturo de la Escalera Percepción 3D 16
>
> <img src="./zjvufbgc.png"
> style="width:1.60157in;height:0.51457in" />**Obtener** **las**
> **normales** **a** **un** **punto**

<img src="./mngrsf52.png"
style="width:7.13937in;height:5.35472in" />**pc** **=**
**pcread('mesa.ply');** **normals** **=** **pcnormals(pc);**
**pcshow(pc);**

**x** **=** **pc.Location(1:100:end,1);** **y** **=**
**pc.Location(1:100:end,2);** **z** **=** **pc.Location(1:100:end,3);**
**u** **=** **normals(1:100:end,1);**

**v** **=** **normals(1:100:end,2);** **w** **=**
**normals(1:100:end,3);** **hold** **on** **quiver3(x,y,z,u,v,w,**
**2);** **hold** **off**

> Arturo de la Escalera Percepción 3D 17
>
> <img src="./0uvqo23c.png"
> style="width:1.60157in;height:0.51457in" />**índice**

**Leer** **y** **escribir** **nubes** **de** **puntos** **Mallas**

**Preprocesamiento** **Encontrar** **un** **plano**

**Funciones** **para** **encontrar** **objetos** **Segmentación**
**por** **distancia**

> Arturo de la Escalera Percepción 3D 18
>
> <img src="./fsd5i4gc.png"
> style="width:1.60157in;height:0.51457in" />**Encontrar** **un**
> **plano**

model = pcfitplane(ptCloudIn,maxDistance) M-estimator SAmple Consensus
(MSAC)

model = pcfitplane(ptCloudIn,maxDistance,referenceVector)

model = pcfitplane(ptCloudIn,maxDistance,referenceVector,maxAngularDist)
\[model,inlierIndices,outlierIndices\] = pcfitplane(ptCloudIn,maxDist)

\[**\_\_\_**,meanError\] = pcfitplane(ptCloudIn,maxDistance)
\[**\_\_\_**\] = pcfitplane(ptCloudIn,maxDistance,Name,Value)

> Arturo de la Escalera Percepción 3D 19
>
> <img src="./ksdpjvgo.png"
> style="width:1.60157in;height:0.51457in" />**Encontrar** **un**
> **plano**

<img src="./babxkq52.png"
style="width:2.6244in;height:1.96811in" /><img src="./rwwb1bbm.png"
style="width:2.6244in;height:1.96811in" />**\>\>**
**\[plano,inlierIndices,outlierIndices\]** **=**
**pcfitplane(pc,0.05);** **\>\>** **plane1** **=**
**select(pc,inlierIndices);**

**\>\>** **pcshow(plane1);**

**\>\>** **resto** **=** **select(pc,outlierIndices);** **\>\>**
**pcshow(resto);**

**\>\>** **pcshow(pc);** **\>\>** **pcshow(resto);**

**\>\>** **\[plano,inlierIndices,outlierIndices\]** **=**
**pcfitplane(resto,0.05);** **\>\>** **plane2** **=**
**select(resto,inlierIndices);**

**\>\>** **pcshow(plane2);**

<img src="./vsbgaoji.png"
style="width:2.6244in;height:1.96811in" /><img src="./ysk0r40s.png"
style="width:2.6244in;height:1.96811in" />**\>\>** **resto2** **=**
**select(resto,outlierIndices);** **\>\>** **pcshow(resto2);**

> Arturo de la Escalera Percepción 3D 20
>
> <img src="./hb3dtkvm.png"
> style="width:1.60157in;height:0.51457in" />**Detectar** **suelo**
> **de**
> **calle1.pcd**<img src="./mnysack1.png" style="width:3.11575in;height:2.1in" />

**\>\>** **vec=\[0** **0** **1\];**

<img src="./jbf5k310.png"
style="width:2.92519in;height:1.97165in" /><img src="./sbnbx25g.png"
style="width:3.4559in;height:2.32953in" /><img src="./peik5tmp.png"
style="width:3.32992in;height:2.85826in" />**\>\>**
**\[plano1,inlierIndices1,outlierIndices1\]** **=**
**pcfitplane(pc,0.2,vec);** **\>\>** **Superficie1** **=**
**select(pc,inlierIndices1);**

**pcshow(pc);** **hold** **on**

**plot(plano1);**

> Arturo de la Escalera Percepción 3D 21
>
> <img src="./5lwq2kuo.png"
> style="width:1.60157in;height:0.51457in" />**índice**

**Leer** **y** **escribir** **nubes** **de** **puntos** **Mallas**

**Preprocesamiento** **Encontrar** **un** **plano**

**Funciones** **para** **encontrar** **objetos** **Segmentación**
**por** **distancia**

> Arturo de la Escalera Percepción 3D 22
>
> <img src="./iiwpfnat.png"
> style="width:1.60157in;height:0.51457in" />**pcfitcylinder**

**model** **=** **pcfitcylinder(ptCloudIn,maxDistance)**

**model** **=** **pcfitcylinder(ptCloudIn,maxDistance,referenceVector)**

**model** **=**
**pcfitcylinder(ptCloudIn,maxDistance,referenceVector,maxAngularDista**
**nce)**

**\[model,inlierIndices,outlierIndices\]** **=**
**pcfitcylinder(ptCloudIn,maxDistance)**

<img src="./wlnldc5h.png"
style="width:5.36654in;height:4.0256in" /> **\[\_\_\_,meanError\]**
**=** **pcfitcylinder(ptCloudIn,maxDistance)**

**\[\_\_\_\]** **=** **pcfitcylinder(\_\_\_,Name,Value)**

> objetos.ply
>
> Arturo de la Escalera Percepción 3D 23
>
> <img src="./0nzwkali.png"
> style="width:1.60157in;height:0.51457in" />**pcfitsphere**

model = pcfitsphere(ptCloudIn,maxDistance)

\[model,inlierIndices,outlierIndices\] =
pcfitsphere(ptCloudIn,maxDistance)

\[**\_\_\_**,meanError\] = pcfitsphere(ptCloudIn,maxDistance)
\[**\_\_\_**\] = pcfitsphere(**\_\_\_**,Name,Value)

> <img src="./upnprqtt.png"
> style="width:5.36654in;height:4.0256in" />objetos.ply
>
> Arturo de la Escalera Percepción 3D 24
>
> <img src="./isrt1sl5.png"
> style="width:1.60157in;height:0.51457in" />**índice**

**Leer** **y** **escribir** **nubes** **de** **puntos** **Mallas**

**Preprocesamiento** **Encontrar** **un** **plano**

**Funciones** **para** **encontrar** **objetos** **Segmentación**
**por** **distancia**

> Arturo de la Escalera Percepción 3D 25

<img src="./axxqifd5.png"
style="width:1.60157in;height:0.51457in" />**Segmentación** **por**
**distancia**

> **labels** **=** **pcsegdist(ptCloud,minDistance)**
>
> **\[labels,numClusters\]** **=** **pcsegdist(ptCloud,minDistance)**
>
> <img src="./oxg2dqqw.png"
> style="width:2.8433in;height:2.44094in" />**pc=pcread("esferas_2.ply");**
> **pcshow(pc);**
>
> **minDistance** **=** **0.5;**
>
> **\[labels,numClusters\]** **=** **pcsegdist(pc,minDistance);**
> **pcshow(pc.Location,labels);**
>
> <img src="./n3rbjpfh.png"
> style="width:2.8433in;height:2.44056in" />**pc1** **=**
> **select(pc,find(labels** **==** **1));** **pcshow(pc1);**
>
> **pc1** **=** **select(pc,find(labels** **==** **2));**
> **pcshow(pc1);**
>
> Arturo de la Escalera Percepción 3D 26

<img src="./r0ncrwcx.png"
style="width:1.60157in;height:0.51457in" />**Segmentación** **por**
**distancia**<img src="./f00fjja2.png"
style="width:7.95315in;height:5.36103in" />

> Arturo de la Escalera Percepción 3D 27
