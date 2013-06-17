From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: vt8500: Add support for I2C bus on Wondermedia
 SoCs
Date: Mon, 17 Jun 2013 09:12:51 +0200
Message-ID: <20130617071250.GA2957@katana>
References: <1371246736-5460-1-git-send-email-linux@prisktech.co.nz>
 <20130615111817.GA2938@katana>
 <51BCE39D.4030505@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51BCE39D.4030505-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Cc: vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 16, 2013 at 09:58:53AM +1200, Tony Prisk wrote:
> On 15/06/13 23:18, Wolfram Sang wrote:
> >On Sat, Jun 15, 2013 at 09:52:16AM +1200, Tony Prisk wrote:
> >>This patch adds support for the I2C bus controllers found on Wondermedia
> >>8xxx-series SoCs. Only master-mode is supported.
> >>
> >>Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> >>---
> >...
> >
> >>+/* REG_TR */
> >>+#define SCL_TIMEOUT(x)		(((x) & 0xFF) << 16)
> >I assume this should be << 8 since all regs are 16 bit wide.
> >
> >Fixed it locally and ready to apply. Please confirm or send a proper
> >fix. Rest looks fine.
> >
> >Thanks for the submission!
> >
> It should be << 8. Please apply your locally corrected version.

Applied to for-next, thanks!


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvrbyAAoJEBQN5MwUoCm2vBQQAKMXsKX7pUN1fcqIfwnzAJgI
kUTY1Bbw7R2xlghCJBkczp/Ici+SStGX44CaJUF/7pMaCu+dphByI1fFCYp/5fYc
kbHFWFpXXye9l1K0To/hWXfgPgvyp6XQNknIYUQieoMH6sp8hJTHbr8vMmD7KPPM
DVDvNbyNgHQ9nvI2p/ycLh4bpNbT97Qa8p0cF0rWoYZCo/5AAuCojezx5e3F1S81
Eryi8dy9co4EApdgMEXjj1/HboADM4iW97vYwB46cw97JEI0DATb1s+RlTFW5wzr
X2kXzmk+od0T5lKSRNwpk8qGEGj4hY1VnfuXldh+pSm2M+1Dc9GJQS6NfMRPtv04
drVHz5NrY+bFGbZUtivA/ui/uInXJa2z69sIctdlRce7VPG+ZKnA1R1GnMi+6R7h
qh8d333wW+jCennsoQG9ayXtMcDHsrIqiukZ+lXe54yJANoJflieRpmeBv4gmRfC
LrJztsYHw0gZxsgfNeKAclH33i/4hcSpaE1AVKXff7MO/Ab+038AJrjGhF0YgWfg
eRl+u75Kef6Npzm3aS6kHL57MqruG2hJlcbgOk60yo3Fdg88bJmPy3XJnMnTkomH
gcuJH3bylHFtGdrT60ORrBoN3/B9U7gC7ygU3lOiSowMQ9qqTu3oS0nHRkvU0kPr
/wuqnKW0QfSe8S0uj8cS
=A1ha
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
