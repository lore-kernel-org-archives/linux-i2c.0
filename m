From: Phil Pokorny <ppokorny@penguincomputing.com>
Subject: Please pick up i2c-xlp9xx driver patches
Date: Wed, 31 Jan 2018 13:01:38 -0800
Message-ID: <CAAek22FfKtt3QzXjcR1WatkFvLuTO5QWSKqCmE7mUGzTG0tZFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8650946913482235042=="
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: openipmi-developer@lists.sourceforge.net, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--===============8650946913482235042==
Content-Type: multipart/alternative; boundary="001a114a9012129109056418c908"

--001a114a9012129109056418c908
Content-Type: text/plain; charset="UTF-8"

Cross-posting to openipmi and linux-i2c...
There are four patches from Cavium starting with
https://lkml.org/lkml/2018/1/18/12 that fix an issue with the xlp9xx driver
that causes ipmi_ssif not to be able to detect a platform BMC.

I have two different pre-production hardware chassis that are affected by
this issue and I don't see that the patches were included in v4.15.

I wonder if either Corey or Jean could/should pick these up and submit
upstream?  There doesn't seem to be a MAINTAINERS entry for the i2c-xlp9xx
The driver was submitted Cavium (was Broadcom at the time)  The posts don't
seem to have gotten any comments on LKML.

I tested the patches and they fix the ipmi_ssif detection issue I had.  So
I'm willing to add "Tested-by" to the patches if that helps.

Would like to see these patches make it up-stream so I can they ask that
they be included in the Red Hat and SuSE distro kernels for ARM64.

Thanks,
Phil P.

--
Philip Pokorny, RHCE
Chief Technology Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

Changing the world through technical innovation

--001a114a9012129109056418c908
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Cross-posting to openipmi and linux-i2c...<br>There a=
re four patches from Cavium starting with <a href=3D"https://lkml.org/lkml/=
2018/1/18/12">https://lkml.org/lkml/2018/1/18/12</a> that fix an issue with=
 the xlp9xx driver that causes ipmi_ssif not to be able to detect a platfor=
m BMC.<br><br></div><div>I have two different pre-production hardware chass=
is that are affected by this issue and I don&#39;t see that the patches wer=
e included in v4.15.<br><br></div><div>I wonder if either Corey or Jean cou=
ld/should pick these up and submit upstream?=C2=A0 There doesn&#39;t seem t=
o be a MAINTAINERS entry for the i2c-xlp9xx=C2=A0 The driver was submitted =
Cavium (was Broadcom at the time)=C2=A0 The posts don&#39;t seem to have go=
tten any comments on LKML.<br><br></div><div>I tested the patches and they =
fix the ipmi_ssif detection issue I had.=C2=A0 So I&#39;m willing to add &q=
uot;Tested-by&quot; to the patches if that helps.<br><br></div><div>Would l=
ike to see these patches make it up-stream so I can they ask that they be i=
ncluded in the Red Hat and SuSE distro kernels for ARM64.<br></div><div><br=
></div><div>Thanks,<br></div><div>Phil P.<br><br>--<br><div class=3D"gmail_=
signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><span><font color=3D=
"#888888">Philip Pokorny, RHCE<br>
Chief Technology Officer<br>
PENGUIN COMPUTING, Inc<br>
<a href=3D"http://www.penguincomputing.com/" target=3D"_blank">www.penguinc=
omputing.com</a><br><br></font></span></div><div><span><font color=3D"#8888=
88">Changing the world through technical innovation<br>
</font></span></div></div></div></div></div>
</div></div>

--001a114a9012129109056418c908--


--===============8650946913482235042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============8650946913482235042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openipmi-developer mailing list
Openipmi-developer@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openipmi-developer

--===============8650946913482235042==--
