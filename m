From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/3] merge calls to of_match_device and of_device_get_match_data
Date: Mon, 21 May 2018 11:49:07 +0200
Message-ID: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: linux-i2c@vger.kernel.org

of_device_get_match_data calls of_match_device and fails if the latter
fails, so both calls aren't needed.

---

 drivers/i2c/muxes/i2c-mux-pca954x.c |    7 ++-----
 drivers/iio/adc/max1363.c           |    8 ++------
 drivers/iio/potentiometer/max5481.c |    7 ++-----
 drivers/iio/potentiometer/mcp4018.c |    7 ++-----
 drivers/iio/potentiometer/mcp4531.c |    7 ++-----
 5 files changed, 10 insertions(+), 26 deletions(-)
