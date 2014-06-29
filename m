From: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Subject: [PATCH v2] i2c: busses: i2c-pxa.c:  Fix for possible null pointer dereferenc
Date: Mon, 30 Jun 2014 01:28:35 +0200
Message-ID: <1404084516-901-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

After discussion with especially Wolfram it was decided to convert the code to use the Managed Device Resource.
I have now tried to create a patch with Devres, hope it is correct.
But a code review is probably more relevant than usual.
I also lack this kind of hardware so preferably should someone do a HW test.

Rickard Strandqvist (1):
  i2c: busses: i2c-pxa.c:  Fix for possible null pointer dereferenc

 drivers/i2c/busses/i2c-pxa.c |   37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

-- 
1.7.10.4
