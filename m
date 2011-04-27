From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 0/2] i2c: tegra: add some new features for tegra i2c
Date: Wed, 27 Apr 2011 18:25:51 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C2CB3DD4DB@HKMAIL01.nvidia.com>
References: <1303301312-15302-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303301312-15302-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org" <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross@a>
List-Id: linux-i2c@vger.kernel.org

Hi, all
Could anyone review these changes?

Thanks
Wei.

-----Original Message-----
From: Wei Ni 
Sent: Wednesday, April 20, 2011 8:09 PM
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org; ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wei Ni
Subject: [PATCH 0/2] i2c: tegra: add some new features for tegra i2c

From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

*** BLURB HERE ***

Wei Ni (2):
  i2c: tegra: Retry transfer when unexpected/no_ack status is detected
  i2c: tegra: use new i2c slave controller

 drivers/i2c/busses/i2c-tegra.c |   57 +++++++++++++++++++++++++++++++++++++--
 include/linux/i2c-tegra.h      |    3 ++
 2 files changed, 57 insertions(+), 3 deletions(-)
