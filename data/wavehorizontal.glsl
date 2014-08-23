/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amp,freq,offset,n/a);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

#define PI 3.1415926

void main()
{
	gl_FragColor=texelFetch(texture,ivec2(clamp(gl_FragCoord.x+sin((gl_FragCoord.y*param*.2+time*.05)*PI*2)*param*size.x*.2,0.,size.x-1.),gl_FragCoord.y),0);
}