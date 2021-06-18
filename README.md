# Earthquack

Earthquack is the final capstone project to complete Udacity iOS Developer Nanodegree program, designed by Gozde Kardas. This application lets users to get latest eartquakes around the world via USGS api. 

In first page, a curious duck welcomes you. You have two options. You can see latest eartquakes or you can see your saved earthquakes. When you click the 'see earthquakes around the world' button, you see a mapview and a table view show the eartquakes happened on last one day. 

In map view, while loading pins, activity indicator welcomes you. If an error occured while getting data, alert view comes to inform user. When activity indicator view goes, you see pins. If you click on a pin, you see place and magnitude informations of the earthquake. And on that pin, you see a + button to add this eartquake to saved eartquakes. By that, you can view that eartquake informations later with 'See saved earthquakes' button.

On saved Earthquakes page, if you click on a cell, that cell will be deleted by that click.

  - UIKit, MapKit, CoreData
  - Mapview, TableView, UIActivityIndicatorView, MKPointAnnotation
  - Navigation Controller, Table Bar Controller , NSFetchedResultsController, UIAlertController
  - HTTP Get Request


