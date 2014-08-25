/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amount);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

float noise(float inp,int n)
{
	inp=abs(inp*100/3.1415926);
	float x=3428.87+mod(n,2)*3982.33-n/2*2873.094;
	float y=1283.54+mod(n,2)*5321.49-n/2*972.45;
	float a=fract(sin(x*floor(inp))*y);
	float b=fract(sin(x*ceil(inp))*y);
	return a+(b-a)*smoothstep(0,1,fract(inp));
}

void main()
{
	ivec2 rp=ivec2((gl_FragCoord.xy-size/2)/(1+param*noise(atan(gl_FragCoord.y-size.y/2,gl_FragCoord.x-size.x/2),0))+size/2);
	ivec2 gp=ivec2((gl_FragCoord.xy-size/2)/(1+param*noise(atan(gl_FragCoord.y-size.y/2,gl_FragCoord.x-size.x/2),1))+size/2);
	ivec2 bp=ivec2((gl_FragCoord.xy-size/2)/(1+param*noise(atan(gl_FragCoord.y-size.y/2,gl_FragCoord.x-size.x/2),2))+size/2);
	float r=texelFetch(texture,rp,0).r;
	float g=texelFetch(texture,gp,0).g;
	float b=texelFetch(texture,bp,0).b;
	gl_FragColor=vec4(r,g,b,1);
}