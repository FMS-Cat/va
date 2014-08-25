/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amp);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

#define PI 3.1415926

int noise=int(sin((fract(sin(gl_FragCoord.x*5783.88)*3478.46))*PI*2.+time*.4)*param*size.y*.2);

void main()
{
	gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.x,clamp(gl_FragCoord.y+noise,0,size.y-1)),0);
}