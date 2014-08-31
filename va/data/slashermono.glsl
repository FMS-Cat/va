/*
.set("size",width,height);
.set("time",frameCount);
.set("param",weight);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

void main()
{
	float s=32;
	vec3 col;
	vec3 tex=texelFetch(texture,ivec2(gl_FragCoord.xy),0).xyz;
	float i=clamp((param*1.2-.1)*s-mod(gl_FragCoord.x-gl_FragCoord.y,s),0.,1.);
	float temp=tex.r+tex.g+tex.b;
	col=vec3(temp/3)*i+tex*(1-i);
	gl_FragColor=vec4(vec3(col),1);
}