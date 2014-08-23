/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amp,freq,offset,n/a);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

vec2 v=vec2(0,1);

float f(vec3 p)
{
    float t=time*.03;
    p.xy*=mat2(cos(t),-sin(t),sin(t),cos(t));
    t=sin(time*.03);
    p.zx*=mat2(cos(t),-sin(t),sin(t),cos(t));
    t=time*.06;
    p.yz*=mat2(cos(t),-sin(t),sin(t),cos(t));
    float r=.1+param*.4;
    float k=.3+param*.1;
    float d=length(p+v.yxx*k)-r;
    d=min(d,length(p-v.yxx*k)-r);
    d=min(d,length(p+v.xyx*k)-r);
    d=min(d,length(p-v.xyx*k)-r);
    d=min(d,length(p+v.xxy*k)-r);
    d=min(d,length(p-v.xxy*k)-r);
    return d;
}

vec3 n(vec3 p){
	vec2 d=vec2(0,.01);
	return normalize(vec3(f(p+d.yxx)-f(p),f(p+d.xyx)-f(p),f(p+d.xxy)-f(p)));
}

void main()
{
	vec2 p=(gl_FragCoord.xy*2.-size.xy)/size.x;
    vec3 r=normalize(v.yxx*p.x+v.xyx*p.y-v.xxy);
    
    float minL=1E-3,maxL=1E4,rL,rD=minL*2.;
    vec3 rP;
    for(int c=0;c<16;c++)
    {
        if(abs(rD)<minL||maxL<rL)break;
        rP=v.xxy+r*rL;
        rD=f(rP);
        rL+=rD;
    }
    
    vec4 col;
    if(mod(gl_FragCoord.x+gl_FragCoord.y,24)<min(param*10.-.5,1.)*24.){
        if(rD<1E-2)
        {
            col=texelFetch(texture,ivec2(size*.5+n(rP).xy*size*.5),0)*(.1/rL*n(rP).z+.9);
        }else{
            col=vec4(0);
        }
    }else{
        col=texelFetch(texture,ivec2(gl_FragCoord.xy),0);
    }
    gl_FragColor=col;
}