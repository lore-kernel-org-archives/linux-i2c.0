From: wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Subject: [PATCH 0/2] i2c: tegra: add some new features for tegra i2c
Date: Wed, 20 Apr 2011 20:08:30 +0800
Message-ID: <1303301312-15302-1-git-send-email-wni@nvidia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org, ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

*** BLURB HERE ***

Wei Ni (2):
  i2c: tegra: Retry transfer when unexpected/no_ack status is detected
  i2c: tegra: use new i2c slave controller

 drivers/i2c/busses/i2c-tegra.c |   57 +++++++++++++++++++++++++++++++++++++--
 include/linux/i2c-tegra.h      |    3 ++
 2 files changed, 57 insertions(+), 3 deletions(-)
