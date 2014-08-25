/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amount);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

float noise(float inp)
{
	inp=abs(inp*100/3.1415926);
	float a=fract(sin(3428.87*floor(inp))*1283.5453);
	float b=fract(sin(3428.87*ceil(inp))*1283.5453);
	return a+(b-a)*smoothstep(0,1,fract(inp));
}

void main()
{
	ivec2 p=ivec2((gl_FragCoord.xy-size/2)/(1+param*noise(atan(gl_FragCoord.y-size.y/2,gl_FragCoord.x-size.x/2)))+size/2);
	gl_FragColor=texelFetch(texture,p,0);
}