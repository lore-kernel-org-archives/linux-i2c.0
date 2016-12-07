From: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: [PATCH 0/2] i2c: sh_mobile: fallback enhancements
Date: Wed,  7 Dec 2016 11:31:27 +0100
Message-ID: <1481106689-22312-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

this short series aims to improve the fallback compatibility strings
for the i2c-sh_mobile driver.

Simon Horman (2):
  i2c: sh_mobile: List rmobile fallback compatibility last
  i2c: sh_mobile: Add per-Generation fallback bindings

 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 17 ++++++++++++++---
 drivers/i2c/busses/i2c-sh_mobile.c                      |  4 +++-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
