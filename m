From: Chuansheng Liu <lcs0208@gmail.com>
Subject: Re: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
Date: Thu, 15 Nov 2012 18:52:36 +0800
Message-ID: <C53EED5A-0C30-44EE-ADD5-6CBABFA3A0FE@gmail.com>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
 <20121115084858.GA29668@bnru10> <20121115092953.GA418@pengutronix.de>
 <20121115095741.GA6280@bnru10>
Mime-Version: 1.0 (iPad Mail 8J3)
Content-Type: multipart/mixed; boundary="===============9221670036613574084=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121115095741.GA6280@bnru10>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "chuansheng.liu@intel.com" <chuansheng.liu@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============9221670036613574084==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative;
	boundary=Apple-Mail-4-1007408005


--Apple-Mail-4-1007408005
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

timeout is never < 0, so status =3D timeout is never getting run. This patch=
 delete pointless
code. Could you show the regression? Thanks.

=E5=9C=A8 2012-11-15=EF=BC=8C17:57=EF=BC=8CSrinidhi Kasagar <srinidhi.kasaga=
r@stericsson.com> =E5=86=99=E9=81=93=EF=BC=9A

> On Thu, Nov 15, 2012 at 10:29:53 +0100, Wolfram Sang wrote:
>>=20
>>>> -       if (timeout < 0) {
>>>> -               dev_err(&dev->adev->dev,
>>>> -                       "wait_for_completion_timeout "
>>>> -                       "returned %d waiting for event\n", timeout);
>>>> -               status =3D timeout;
>>>> -       }
>>>> -
>>> No, it is wrong. You need to update the status variable in the case of t=
imeout.
>>=20
>> Looking at the patch context, such code comes later.
> But it causes regressions; without looking at the "later" code, we can't a=
fford merging
> this code now.
>=20
> regards/srinidhi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Apple-Mail-4-1007408005
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body bgcolor=3D"#FFFFFF"><div>timeout is never &lt; 0, so&nbsp;<span c=
lass=3D"Apple-style-span" style=3D"-webkit-tap-highlight-color: rgba(26, 26,=
 26, 0.292969); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469=
); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); color: rgb=
(148, 0, 14); ">status =3D timeout is never getting run. This patch delete p=
ointless</span></div><div><font class=3D"Apple-style-span" color=3D"#94000E"=
><span class=3D"Apple-style-span" style=3D"-webkit-tap-highlight-color: rgba=
(26, 26, 26, 0.292969); -webkit-composition-fill-color: rgba(175, 192, 227, 0=
.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469);">co=
de. Could you show the regression? Thanks.<br></span></font><br></div><div>=E5=
=9C=A8 2012-11-15=EF=BC=8C17:57=EF=BC=8CSrinidhi Kasagar &lt;<a href=3D"mail=
to:srinidhi.kasagar@stericsson.com">srinidhi.kasagar@stericsson.com</a>&gt; =E5=
=86=99=E9=81=93=EF=BC=9A<br><br></div><div></div><blockquote type=3D"cite"><=
div><span>On Thu, Nov 15, 2012 at 10:29:53 +0100, Wolfram Sang wrote:</span>=
<br><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>- &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (timeout &lt; 0) {</span><br></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev_err(&amp;dev-&gt;adev-&gt;dev=
,</span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"wait_for_completion_timeout "</spa=
n><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"returned %d waiting for event\n", timeou=
t);</span><br></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>- &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;statu=
s =3D timeout;</span><br></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>- &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>-</span><br></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>No, it is wrong. You need t=
o update the status variable in the case of timeout.</span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockq=
uote type=3D"cite"><span>Looking at the patch context, such code comes later=
.</span><br></blockquote><span>But it causes regressions; without looking at=
 the "later" code, we can't afford merging</span><br><span>this code now.</s=
pan><br><span></span><br><span>regards/srinidhi</span><br><span>--</span><br=
><span>To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in</span><br><span>the body of a message to <a href=3D"mailto:majordomo@v=
ger.kernel.org"><a href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.=
kernel.org</a></a></span><br><span>More majordomo info at &nbsp;<a href=3D"h=
ttp://vger.kernel.org/majordomo-info.html"><a href=3D"http://vger.kernel.org=
/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a></a></sp=
an><br><span>Please read the FAQ at &nbsp;<a href=3D"http://www.tux.org/lkml=
/"><a href=3D"http://www.tux.org/lkml/">http://www.tux.org/lkml/</a></a></sp=
an><br></div></blockquote></body></html>=

--Apple-Mail-4-1007408005--


--===============9221670036613574084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9221670036613574084==--
