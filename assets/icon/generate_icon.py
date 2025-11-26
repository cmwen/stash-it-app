#!/usr/bin/env python3
"""
Stash It App Icon Generator
Creates PNG icons for the Flutter app in various sizes.

Usage: python3 generate_icon.py
"""

import os
import struct
import zlib
from pathlib import Path

def create_png(width, height, pixels, filepath):
    """Create a PNG file from raw RGBA pixel data."""
    def png_chunk(chunk_type, data):
        chunk = chunk_type + data
        crc = zlib.crc32(chunk) & 0xffffffff
        return struct.pack('>I', len(data)) + chunk + struct.pack('>I', crc)
    
    # PNG signature
    signature = b'\x89PNG\r\n\x1a\n'
    
    # IHDR chunk
    ihdr_data = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
    ihdr = png_chunk(b'IHDR', ihdr_data)
    
    # IDAT chunk (image data)
    raw_data = b''
    for y in range(height):
        raw_data += b'\x00'  # Filter byte (none)
        for x in range(width):
            idx = (y * width + x) * 4
            raw_data += bytes(pixels[idx:idx+4])
    
    compressed = zlib.compress(raw_data, 9)
    idat = png_chunk(b'IDAT', compressed)
    
    # IEND chunk
    iend = png_chunk(b'IEND', b'')
    
    with open(filepath, 'wb') as f:
        f.write(signature + ihdr + idat + iend)

def blend_colors(bg, fg, alpha):
    """Blend foreground color with background using alpha."""
    a = alpha / 255.0
    return tuple(int(bg[i] * (1 - a) + fg[i] * a) for i in range(3)) + (255,)

def draw_rounded_rect(pixels, width, height, x1, y1, x2, y2, radius, color):
    """Draw a filled rounded rectangle."""
    for y in range(y1, y2):
        for x in range(x1, x2):
            # Check if point is inside rounded rect
            inside = True
            
            # Check corners
            corners = [
                (x1 + radius, y1 + radius),  # top-left
                (x2 - radius, y1 + radius),  # top-right
                (x1 + radius, y2 - radius),  # bottom-left
                (x2 - radius, y2 - radius),  # bottom-right
            ]
            
            for cx, cy in corners:
                # Check if in corner region
                if (x < x1 + radius and y < y1 + radius):  # top-left
                    dx, dy = x - (x1 + radius), y - (y1 + radius)
                    if dx * dx + dy * dy > radius * radius:
                        inside = False
                elif (x >= x2 - radius and y < y1 + radius):  # top-right
                    dx, dy = x - (x2 - radius - 1), y - (y1 + radius)
                    if dx * dx + dy * dy > radius * radius:
                        inside = False
                elif (x < x1 + radius and y >= y2 - radius):  # bottom-left
                    dx, dy = x - (x1 + radius), y - (y2 - radius - 1)
                    if dx * dx + dy * dy > radius * radius:
                        inside = False
                elif (x >= x2 - radius and y >= y2 - radius):  # bottom-right
                    dx, dy = x - (x2 - radius - 1), y - (y2 - radius - 1)
                    if dx * dx + dy * dy > radius * radius:
                        inside = False
            
            if inside and 0 <= x < width and 0 <= y < height:
                idx = (y * width + x) * 4
                if len(color) == 4 and color[3] < 255:
                    # Alpha blending
                    bg = pixels[idx:idx+4]
                    blended = blend_colors(bg, color, color[3])
                    pixels[idx:idx+4] = list(blended)
                else:
                    pixels[idx:idx+4] = list(color[:4]) if len(color) >= 4 else list(color) + [255]

def draw_bookmark(pixels, width, height, cx, cy, scale, color):
    """Draw a bookmark icon centered at cx, cy with given scale."""
    # Bookmark dimensions relative to scale
    bw = int(200 * scale)  # bookmark width
    bh = int(300 * scale)  # bookmark height
    notch = int(80 * scale)  # notch depth
    
    x1 = cx - bw // 2
    x2 = cx + bw // 2
    y1 = cy - bh // 2
    y2 = cy + bh // 2 - notch
    
    # Draw main rectangle part
    draw_rounded_rect(pixels, width, height, x1, y1, x2, y2 + notch, int(20 * scale), color)
    
    # Draw the notch (triangle cutout effect) by drawing the bookmark shape
    # We'll draw the bookmark as a filled polygon
    for y in range(y1, y2 + notch + int(50 * scale)):
        for x in range(x1, x2):
            if 0 <= x < width and 0 <= y < height:
                idx = (y * width + x) * 4
                
                # Check if we're in the notch area
                if y > y2:
                    # In the notch triangle area
                    rel_y = y - y2
                    notch_width = int((rel_y / notch) * (bw // 2))
                    if x < cx - notch_width or x > cx + notch_width:
                        continue  # Outside the notch triangle
                    elif y > y2 + notch:
                        continue  # Below the notch point
                
                # Check rounded corners at top
                corner_radius = int(20 * scale)
                in_corner = False
                if x < x1 + corner_radius and y < y1 + corner_radius:
                    dx, dy = x - (x1 + corner_radius), y - (y1 + corner_radius)
                    if dx * dx + dy * dy > corner_radius * corner_radius:
                        in_corner = True
                elif x >= x2 - corner_radius and y < y1 + corner_radius:
                    dx, dy = x - (x2 - corner_radius - 1), y - (y1 + corner_radius)
                    if dx * dx + dy * dy > corner_radius * corner_radius:
                        in_corner = True
                
                if not in_corner:
                    if len(color) == 4 and color[3] < 255:
                        bg = pixels[idx:idx+4]
                        blended = blend_colors(bg, color, color[3])
                        pixels[idx:idx+4] = list(blended)
                    else:
                        pixels[idx:idx+4] = list(color[:4]) if len(color) >= 4 else list(color) + [255]

def draw_arrow_down(pixels, width, height, cx, cy, scale, color):
    """Draw a downward arrow icon."""
    aw = int(60 * scale)  # arrow shaft width
    ah = int(80 * scale)  # arrow shaft height
    head_w = int(100 * scale)  # arrow head width
    head_h = int(50 * scale)  # arrow head height
    
    # Draw shaft
    for y in range(cy - ah, cy):
        for x in range(cx - aw // 2, cx + aw // 2):
            if 0 <= x < width and 0 <= y < height:
                idx = (y * width + x) * 4
                if len(color) == 4 and color[3] < 255:
                    bg = pixels[idx:idx+4]
                    blended = blend_colors(bg, color, color[3])
                    pixels[idx:idx+4] = list(blended)
                else:
                    pixels[idx:idx+4] = list(color[:4])
    
    # Draw arrow head (triangle)
    for y in range(cy, cy + head_h):
        rel_y = y - cy
        half_width = int(head_w * (1 - rel_y / head_h) / 2)
        for x in range(cx - half_width, cx + half_width):
            if 0 <= x < width and 0 <= y < height:
                idx = (y * width + x) * 4
                if len(color) == 4 and color[3] < 255:
                    bg = pixels[idx:idx+4]
                    blended = blend_colors(bg, color, color[3])
                    pixels[idx:idx+4] = list(blended)
                else:
                    pixels[idx:idx+4] = list(color[:4])

def generate_icon(size, filepath):
    """Generate a Stash It app icon at the specified size."""
    # Initialize pixel array with transparent
    pixels = [0] * (size * size * 4)
    
    # Colors
    primary = (103, 80, 164, 255)  # #6750A4
    primary_light = (123, 104, 238, 255)  # Lighter purple for gradient effect
    white = (255, 255, 255, 255)
    accent_overlay = (103, 80, 164, 80)  # Translucent purple
    
    # Draw background
    radius = int(size * 0.22)  # ~22% corner radius
    
    # Simple gradient effect - draw two overlapping rounded rects
    draw_rounded_rect(pixels, size, size, 0, 0, size, size, radius, primary)
    
    # Draw bookmark icon
    scale = size / 1024.0
    cx, cy = size // 2, size // 2
    
    # Main white bookmark
    draw_bookmark(pixels, size, size, cx, cy, scale, white)
    
    # Draw inner line decoration (top of bookmark)
    line_y1 = int(cy - 120 * scale)
    line_y2 = int(cy - 80 * scale)
    line_x1 = int(cx - 80 * scale)
    line_x2 = int(cx + 80 * scale)
    draw_rounded_rect(pixels, size, size, line_x1, line_y1, line_x2, line_y2, int(6 * scale), accent_overlay)
    
    # Draw down arrow inside bookmark
    arrow_cy = int(cy + 20 * scale)
    draw_arrow_down(pixels, size, size, cx, arrow_cy, scale * 0.6, accent_overlay)
    
    create_png(size, size, pixels, filepath)
    print(f"✅ Created {filepath} ({size}x{size})")

def main():
    # Create output directory
    output_dir = Path("assets/icon")
    output_dir.mkdir(parents=True, exist_ok=True)
    
    print("🎨 Generating Stash It app icons...\n")
    
    # Generate main icon
    generate_icon(1024, output_dir / "icon.png")
    
    # Generate foreground for adaptive icons (same as main but will be used with colored bg)
    generate_icon(1024, output_dir / "icon_foreground.png")
    
    # Generate various sizes for different platforms
    sizes = [
        (48, "icon-48.png"),
        (72, "icon-72.png"),
        (96, "icon-96.png"),
        (144, "icon-144.png"),
        (192, "icon-192.png"),
        (512, "icon-512.png"),
    ]
    
    for size, filename in sizes:
        generate_icon(size, output_dir / filename)
    
    print("\n✨ All icons generated successfully!")
    print("\n📋 Next steps:")
    print("1. Add flutter_launcher_icons to dev_dependencies")
    print("2. Run: dart run flutter_launcher_icons")

if __name__ == "__main__":
    main()
