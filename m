From: Craig Matsuura <cmatsuura-/SMLdF/PHsZWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Fri, 18 Sep 2009 23:12:57 -0600
Message-ID: <200909182312.58018.cmatsuura@control4.com>
References: <1247643267.5981.82.camel@localhost.localdomain>
	<218571.29671.qm@web50101.mail.re2.yahoo.com>
	<1248261275.4077.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1056081309=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1248261275.4077.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============1056081309==
Content-Type: multipart/alternative; boundary="Boundary-00=_ahGtKKu0qRDOkHU"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_ahGtKKu0qRDOkHU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The patch submitted appears specific to the dm355.  The changes are very 
similar to the 2.6.10 kernel from mv.  If the correct gpio's and pinmux are 
disabled/enabled it should work for the dm644x.  

I took the patch from Philby and tried it on our dm6443 platform (on a 2.6.28 
kernel) and it appears to work for the problem we have when the i2c appears to 
lock up.

Craig


On Wednesday 22 July 2009 5:14:35 am Philby John wrote:
> On Wed, 2009-07-22 at 04:03 -0700, Nitin Mahajan wrote:
> > Hello,
> >
> > ----- Original Message ----
> >
> > > From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > > To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> > > Sent: Wednesday, July 15, 2009 13:04:27
> > > Subject: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
> > >
> > > >From dbe7e824d576636bb15b82a20fd2557fddc9a8f7 Mon Sep 17 00:00:00 2001
> > >
> > > From: Philby John
> > > Date: Tue, 14 Jul 2009 21:46:47 +0530
> > > Subject: [PATCH] Reset i2c bus to come out of time out conditions
> > >
> > > Get out of i2c time out condition by resetting
> > > the i2c bus. The kernel must be robust enough to
> > > gracefully recover from i2c bus failure without having
> > > to reset the machine. This is done by first NACKing the slave
> > > and then resetting the i2c bus after a certain timeout.
> > >
> > > Signed-off-by: Philby John
> >
> > I tried this on DM6443 based board with 2.6.18 kernel. The result I am
> > posting below. It gives controller time out again and again.
> >
> > dhcppc9 login: i2c_davinci i2c_davinci.1: controller timed out
> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> > i2c_davinci i2c_davinci.1: controller timed out
> > i2c_davinci i2c_davinci.1: initiating i2c bus recovery
>
> There is something gravely wrong about this patch and I would submit a
> fix shortly incorporating the review comments. But please be aware that
> I do not guarantee a definitive time line for a fix cause I have much at
> hand at the moment.
>
>
> Regards,
> Philby
>
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source

-- 




Craig Matsuura - Principal Engineer
Control4
11734 South Election Road - Suite 200
Salt Lake City, UT 84020-6432
PH: 801-523-3161
FX: 801-523-3199

--Boundary-00=_ahGtKKu0qRDOkHU
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'DejaVu Sans'; font-size:9pt; font-weight:400; font-style:normal;">The patch submitted appears specific to the dm355.  The changes are very similar to the 2.6.10 kernel from mv.  If the correct gpio's and pinmux are disabled/enabled it should work for the dm644x.  <br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>I took the patch from Philby and tried it on our dm6443 platform (on a 2.6.28 kernel) and it appears to work for the problem we have when the i2c appears to lock up.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Craig<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>On Wednesday 22 July 2009 5:14:35 am Philby John wrote:<br>
&gt; On Wed, 2009-07-22 at 04:03 -0700, Nitin Mahajan wrote:<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; ----- Original Message ----<br>
&gt; &gt;<br>
&gt; &gt; &gt; From: Philby John &lt;pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org&gt;<br>
&gt; &gt; &gt; To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
&gt; &gt; &gt; Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org<br>
&gt; &gt; &gt; Sent: Wednesday, July 15, 2009 13:04:27<br>
&gt; &gt; &gt; Subject: [PATCH/RFC 1/1] recover from davinci i2c time out conditions<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;From dbe7e824d576636bb15b82a20fd2557fddc9a8f7 Mon Sep 17 00:00:00 2001<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From: Philby John<br>
&gt; &gt; &gt; Date: Tue, 14 Jul 2009 21:46:47 +0530<br>
&gt; &gt; &gt; Subject: [PATCH] Reset i2c bus to come out of time out conditions<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Get out of i2c time out condition by resetting<br>
&gt; &gt; &gt; the i2c bus. The kernel must be robust enough to<br>
&gt; &gt; &gt; gracefully recover from i2c bus failure without having<br>
&gt; &gt; &gt; to reset the machine. This is done by first NACKing the slave<br>
&gt; &gt; &gt; and then resetting the i2c bus after a certain timeout.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Philby John<br>
&gt; &gt;<br>
&gt; &gt; I tried this on DM6443 based board with 2.6.18 kernel. The result I am<br>
&gt; &gt; posting below. It gives controller time out again and again.<br>
&gt; &gt;<br>
&gt; &gt; dhcppc9 login: i2c_davinci i2c_davinci.1: controller timed out<br>
&gt; &gt; i2c_davinci i2c_davinci.1: initiating i2c bus recovery<br>
&gt; &gt; i2c_davinci i2c_davinci.1: controller timed out<br>
&gt; &gt; i2c_davinci i2c_davinci.1: initiating i2c bus recovery<br>
&gt;<br>
&gt; There is something gravely wrong about this patch and I would submit a<br>
&gt; fix shortly incorporating the review comments. But please be aware that<br>
&gt; I do not guarantee a definitive time line for a fix cause I have much at<br>
&gt; hand at the moment.<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Philby<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Davinci-linux-open-source mailing list<br>
&gt; Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org<br>
&gt; http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source<br>
<br />-- <br /><br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><hr /><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><span style=" font-weight:600;">Craig Matsuura - Principal Engineer</span><br>
Control4<br>
11734 South Election Road - Suite 200<br>
Salt Lake City, UT 84020-6432<br>
PH: 801-523-3161<br>
FX: 801-523-3199</p></body></html>
--Boundary-00=_ahGtKKu0qRDOkHU--


--===============1056081309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1056081309==--
