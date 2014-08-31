/*
.set("size",width,height);
.set("time",frameCount);
.set("param",sizeOfTri);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

void comp(ivec2 v2,inout ivec2 v3,ivec2 i)
{
	if(length(v2-i)<length(v2-v3))
	{
		v3=i;
	}
}

void main()
{
	if(param<.05)
	{
		gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.xy),0);
	}
	else
	{
		int wid=int(max(size.x/pow(2,int(11-round(param*10))),1));
		int wid3=int(round(wid*sqrt(3)));
		ivec2 v1=ivec2(gl_FragCoord.xy-mod(gl_FragCoord.xy,vec2(wid*2,wid3*2)));

		ivec2 v2=ivec2(mod(gl_FragCoord.xy,vec2(wid*2,wid3*2)));

		ivec2 v3=ivec2(0);
		comp(v2,v3,ivec2(wid*2,0));
		comp(v2,v3,ivec2(wid,wid3));
		comp(v2,v3,ivec2(0,wid3*2));
		comp(v2,v3,ivec2(wid*2,wid3*2));

		ivec2 p=ivec2(clamp(v1+v3,ivec2(1),ivec2(size-1)));

		gl_FragColor=texelFetch(texture,p,0);
	}
}