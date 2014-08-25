/*
.set("size",width,height);
.set("time",frameCount);
.set("param",split);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform ivec2 E0;
uniform ivec2 E1;
uniform ivec2 E2;
uniform ivec2 E3;
uniform ivec2 E01;
uniform ivec2 E11;
uniform ivec2 E21;
uniform ivec2 E31;
uniform ivec2 E02;
uniform ivec2 E12;
uniform ivec2 E22;
uniform ivec2 E32;
uniform ivec2 E03;
uniform ivec2 E13;
uniform ivec2 E23;
uniform ivec2 E33;

int done=0;

void pm(ivec2 e0,ivec2 e1,ivec2 e2,ivec2 e3)
{
	if((gl_FragCoord.x-e0.x)/(e3.x-e0.x)*(e3.y-e0.y)>(gl_FragCoord.y-e0.y))
	{
		mat2 m0=mat2((e3.x-e2.x)*1./size.x,(e3.y-e2.y)*1./size.x,(e0.x-e2.x)*1./size.y,(e0.y-e2.y)*1./size.y);
		vec2 p=inverse(m0)*vec2(gl_FragCoord.xy-vec2(e2));
		if(0<p.x&&p.x<size.x&&0<p.y&&p.y<size.y&&texelFetch(texture,ivec2(p.x,size.y-p.y)*textureSize(texture,0)/size,0).w>.2)
		{
			gl_FragColor=texelFetch(texture,ivec2(p.x,p.y)*textureSize(texture,0)/size,0);
			done=1;
		}
	}else{
		ivec2 ofs=ivec2(e3.x+e0.x-e1.x,e3.y+e0.y-e1.y);
		mat2 m0=mat2((e3.x-ofs.x)*1./size.x,(e3.y-ofs.y)*1./size.x,(e0.x-ofs.x)*1./size.y,(e0.y-ofs.y)*1./size.y);
		vec2 p=inverse(m0)*vec2(gl_FragCoord.xy-ofs);
		gl_FragColor=texelFetch(texture,ivec2(p),0);
		if(0<p.x&&p.x<size.x&&0<p.y&&p.y<size.y&&texelFetch(texture,ivec2(p.x,size.y-p.y)*textureSize(texture,0)/size,0).w>.2)
		{
			gl_FragColor=texelFetch(texture,ivec2(p.x,p.y)*textureSize(texture,0)/size,0);
			done=1;
		}
	}
}

void main()
{
	pm(ivec2(E03.x,size.y-E03.y),ivec2(E13.x,size.y-E13.y),ivec2(E23.x,size.y-E23.y),ivec2(E33.x,size.y-E33.y));
	if(done==1)return;
	pm(ivec2(E02.x,size.y-E02.y),ivec2(E12.x,size.y-E12.y),ivec2(E22.x,size.y-E22.y),ivec2(E32.x,size.y-E32.y));
	if(done==1)return;
	pm(ivec2(E01.x,size.y-E01.y),ivec2(E11.x,size.y-E11.y),ivec2(E21.x,size.y-E21.y),ivec2(E31.x,size.y-E31.y));
	if(done==1)return;
	pm(ivec2(E0.x,size.y-E0.y),ivec2(E1.x,size.y-E1.y),ivec2(E2.x,size.y-E2.y),ivec2(E3.x,size.y-E3.y));
	if(done==0)
	{
		gl_FragColor=vec4(0,0,0,1);
	}
}