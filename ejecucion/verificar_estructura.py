#!/usr/bin/env python3
"""
Verificar estructura completa del documento: 8.XX.1 a 8.XX.7 para cada ficha
"""

from docx import Document
import re

def verificar_estructura(filepath):
    doc = Document(filepath)
    
    # Extraer todo el texto
    full_text = []
    for para in doc.paragraphs:
        if para.text.strip():
            full_text.append(para.text.strip())
    
    all_text = '\n'.join(full_text)
    
    # Verificar cada ficha
    print("=== VERIFICACIÓN DE ESTRUCTURA POR FICHA ===\n")
    
    fichas_ok = 0
    fichas_error = 0
    
    for num in range(1, 42):
        ficha_num = f"{num:02d}"
        secciones = {
            f'8.{num}.1': 'Resumen Ejecutivo',
            f'8.{num}.2': 'Identificación/Datos del Componente',
            f'8.{num}.3': 'Descripción Funcional/Técnica',
            f'8.{num}.4': 'Justificación Estratégica',
            f'8.{num}.5': 'Especificación Técnica',
            f'8.{num}.6': 'Requerimientos Funcionales (RF)',
            f'8.{num}.7': 'Requisitos No Funcionales (RNF)',
            f'8.{num}.8': 'KPIs'
        }
        
        # Buscar la ficha en el texto
        encontrada = False
        for line in full_text:
            if f'CC-{ficha_num}' in line or f'8.{num}.' in line[:6]:
                encontrada = True
                break
        
        if not encontrada:
            print(f"CC-{ficha_num}: NO ENCONTRADA")
            fichas_error += 1
            continue
        
        # Verificar secciones
        secciones_ok = 0
        for codigo, nombre in secciones.items():
            if codigo in all_text:
                secciones_ok += 1
        
        if secciones_ok >= 6:  # Al menos 6 secciones principales
            print(f"CC-{ficha_num}: ✓ ({secciones_ok}/8 secciones)")
            fichas_ok += 1
        else:
            print(f"CC-{ficha_num}: ⚠ ({secciones_ok}/8 secciones)")
            fichas_error += 1
    
    print(f"\n=== RESUMEN ===")
    print(f"Fichas completas: {fichas_ok}/41")
    print(f"Fichas con error: {fichas_error}/41")
    
    # Contar tablas RF, RNF, KPIs
    rf_count = all_text.count('RF-')
    rnf_count = all_text.count('RNF-')
    kpi_count = all_text.count('KPI-')
    
    print(f"\nConteos de elementos:")
    print(f"RF-XX (Requerimientos Funcionales): ~{rf_count}")
    print(f"RNF-XX (Requisitos No Funcionales): ~{rnf_count}")
    print(f"KPI-XX (Indicadores): ~{kpi_count}")

if __name__ == '__main__':
    filepath = '/root/.openclaw/workspace/ejecucion/8_REQUERIMIENTOS_COMPLETO_41_ITS.docx'
    verificar_estructura(filepath)
