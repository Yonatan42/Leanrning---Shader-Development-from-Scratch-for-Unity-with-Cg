Shader "Course/P03/Hollistic/BumpDiffuse" {

    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {} // the normal map - note that we need to change the texture type in unity to normal map (instead of default)
        _mySlider ("Bump Amount", Range(0,10)) = 1 // slider for the intensity of the normal map
        _myBright ("Brightness", Range(0, 10)) = 1 // the brightness of the normal
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myDiffuse;
            sampler2D _myBump;
            half _mySlider;
            half _myBright;

            struct Input {
                float2 uv_myDiffuse;
                float2 uv_myBump;
            };

            // version 1 - normal map
            /*
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
                // UnpackNormal gets the normal values from a tex2D
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
            }
            */

            // version 2 - add normal map intensity
            /*
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
                // UnpackNormal gets the normal values from a tex2D
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
                // after calculating the normal, we multiply it by the slider value to change the intensity of it
                // x and y are the slider value and z is constant 1
                o.Normal *= float3(_mySlider, _mySlider, 1);
            }
            */

            // version 3 - add brightness along with intensity
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
                // UnpackNormal gets the normal values from a tex2D
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * _myBright; // multiply the resuly by the britness to change the brightness of the normal
                // after calculating the normal, we multiply it by the slider value to change the intensity of it
                // x and y are the slider value and z is constant 1
                o.Normal *= float3(_mySlider, _mySlider, 1);
            }

        ENDCG
    }

    Fallback "Diffuse"
}