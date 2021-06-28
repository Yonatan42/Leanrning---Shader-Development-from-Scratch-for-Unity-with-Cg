Shader "Course/P02/Hollistic/AllProps" {

    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 1
        _myTex ("Example Texture", 2D) = "white" {}
        _myCube ("Example Cube", CUBE) = "" {}
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5,1,1,1)
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            fixed4 _myColor;
            half _myRange;
            sampler2D _myTex;
            samplerCUBE _myCube;
            float _myFloat;
            float4 _myVector;

            struct Input {
                // the first uv (we are allowed up to two)
                // note that the "uv_myTex" is build from the parts "uv" and then the param name above (in this case "_myTex") and making the field name this way is NECESSARY
                float2 uv_myTex; 
                // world reflection values
                float3 worldRefl;
            };

            // version 1 - appy texture 
            /*
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = tex2D(_myTex, IN.uv_myTex).rgb;
                // tex2D(...) - function that is part of the shader language
                // tex2D(_myTex, IN.uv_myTex) - applying the uv onto the input texture
                // o.Albedo = tex2D(_myTex, IN.uv_myTex).rgb - applying the colors from the previous line to the albedo
            }
            */

            // version 2 - appy texture with range
            /*
            void surf (Input IN, inout SurfaceOutput o){
                // multiply the output texture by the range value 
                // this makes the resulting color righter for higher values above 1 and darker for values below 1
                o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb;
            }
            */

            // version 3 - add cubemap for emission
            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb;
                o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
            }

        ENDCG
    }

    Fallback "Diffuse"
}