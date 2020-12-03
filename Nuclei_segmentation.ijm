dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Color Devonvoluted Directory ");

list = getFileList(dir1);
setBatchMode(true);


for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
 	open(dir1+list[i]);

 	
	 
 	// INSERT MACRO HERE

	imageName = getTitle();
	run("Colour Deconvolution", "vectors=[H&E]");
	selectWindow(imageName + "-(Colour_3)");
	close();

	selectWindow(imageName + "-(Colour_2)");
	//imageName_eosin = getTitle();
	//saveAs("TIFF", dir2+imageName_eosin);
	close();

	selectWindow(imageName + "-(Colour_1)");
	imageName_hemotoxylin = getTitle();
	//saveAs("jpeg", dir2+imageName_hemotoxylin);
	
	//Analysis
	run("Threshold...");
    setThreshold(0,85);
	run("Convert to Mask");

	run("Make Binary");

	run("Watershed");

	run("Analyze Particles...", "size=150-Infinity show=Masks clear include");

	saveAs("TIFF", dir2+imageName_hemotoxylin+"Thresh85_size150");
	close();
}
	