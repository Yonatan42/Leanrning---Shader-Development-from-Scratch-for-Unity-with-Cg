Shader "Course/P03/Hollistic/BumpEnv" {

    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {} 
        _mySlider ("Bump Amount", Range(0,10)) = 1 
        _myBright ("Brightness", Range(0, 10)) = 1 
        _myCube ("Cube Map", CUBE) = "white" {}
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myDiffuse;
            sampler2D _myBump;
            half _mySlider;
            half _myBright;
            samplerCUBE _myCube;

            struct Input {
                float2 uv_myDiffuse;
                float2 uv_myBump;

                 //note that this one is a float3 because with the reflection we are working with 3D data
                float3 worldRefl; INTERNAL_DATA 
                // the "INTERNAL_DATA":
                // the the world reflection data and the normals depend on each other so there would be a circular dependency
                // so we state the the world reflection data (worldRefl) is internal only
            };

           
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * _myBright;
                o.Normal *= float3(_mySlider, _mySlider, 1);
                // WorldReflectionVector is an internal function which calculates the reflection vector given the input and the normal
                o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
            }

        ENDCG
    }

    Fallback "Diffuse"
}