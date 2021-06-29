Shader "Course/P04/Hollistic/DotProduct" {

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float3 viewDir; // the viewer's vectore (the screen inward to the object)
            };

            void surf (Input IN, inout SurfaceOutput o){
                // the dot product of the veiw direction with the normal is as follows:
                // 1 when the viewer direction is the same as the normal
                // positive if the viewer can see it (higher when closer to the normal)
                // 0 when at a right angle to the viewer
                // negative if hidden from the viewer
               half dotp = dot(IN.viewDir, o.Normal);
               o.Albedo = float3(dotp, 1, 1); // the part flat to the viewer will be white and anything else the viewer can see will be almost with to blue depending on the angle
               // (the closer to flat the whiter is will be)

            }

        ENDCG
    }

    Fallback "Diffuse"
}