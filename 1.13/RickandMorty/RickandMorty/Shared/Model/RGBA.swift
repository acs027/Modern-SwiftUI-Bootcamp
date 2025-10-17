//
//  RGBA.swift
//  RickandMorty
//
//  Created by ali cihan on 25.09.2025.
//


struct RGBA {
    let r: Double
    let g: Double
    let b: Double
    let a: Double
    
    static func red() -> RGBA {
            return RGBA(r: 1, g: 0, b: 0, a: 1)
        }
        
        static func green() -> RGBA {
            return RGBA(r: 0.2, g: 0.8, b: 0.4, a: 1)
        }
        
        static func blue() -> RGBA {
            return RGBA(r: 0, g: 0.5, b: 1, a: 1)
        }
        
        static func gray() -> RGBA {
            return RGBA(r: 0.6, g: 0.6, b: 0.6, a: 1)
        }
}