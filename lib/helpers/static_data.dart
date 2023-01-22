import 'package:flutter/material.dart';

//TODO: Use Storage from appwrite instead of storing images locally

String getImageFromName(String name) {
  switch (name) {
    case 'Typhoid':
      return "assets/images/typhoid.png";
    case 'Chicken Pox':
      return "assets/images/chicken_pox.png";
    case 'Malaria':
      return "assets/images/malaria.png";
    case 'Common Cold':
      return "assets/images/cold.png";
    case 'Headaches':
      return "assets/images/headache.png";
    case 'Tubercolosis':
      return "assets/images/tubercolosis.png";
    case 'Diarrhea':
      return "assets/images/diarrhea.png";
  }
  return "assets/images/cold.png";
}
