From: Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 6/7] iio: srf08: add buffered to device mode
Date: Thu, 3 Aug 2017 01:26:09 +0200
Message-ID: <20170802232609.GA15406@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Add INDIO_BUFFER_TRIGGERED and INDIO_BUFFER_SOFTWARE to device mode

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index a63c272c3b22..ea238ab1066c 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -437,7 +437,9 @@ static int srf08_probe(struct i2c_client *client,
 
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE
+				| INDIO_BUFFER_TRIGGERED
+				| INDIO_BUFFER_SOFTWARE;
 
 	/* srf02 is not using sensitivity nor max_range */
 	if (id->driver_data == SRF02)
-- 
2.1.4


-- 
