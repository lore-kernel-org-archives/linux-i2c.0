From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/5] i2c: mux: pca9541: extend with support for pca9641
Date: Wed, 6 Mar 2019 23:15:29 +0000
Message-ID: <20190306231521.29367-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ken Chen <chen.kenyy@inventec.com>, Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
List-Id: linux-i2c@vger.kernel.org

Hi!

So, it's been a year or so since this was last visited. Time flies.
At that time, Ken Chen gave up and I didn't want to add untested
code. However, Pradeep Srinivasan asked about PCA9641 and so I have
now rebased the preparatory patches to v5.0 and added the bits Ken
wrote on top of the framework I wrote.

Looking forward to some test results, this has only been build-tested.
The actual code that does anything remotely interesting with the
PCA9641 is all Kens work, and I have no knowledge if it works or not.

Changes since last year   (https://lkml.org/lkml/2018/3/20/205)
- rebased to v5.0
- changed a couple of helper functions to return bool instead of int 0/1
- added dt-bindings patch
- warped Kens patch to fit on top of the preparatory work in patches 1-3

Cheers,
Peter

Peter Rosin (5):
  i2c: mux: pca9541: use the BIT macro
  i2c: mux: pca9541: namespace cleanup
  i2c: mux: pca9541: prepare for PCA9641 support
  dt-bindings: i2c: pca9541: extend with compatible for PCA9641
  i2c: mux: pca9541: add support for PCA9641

 .../devicetree/bindings/i2c/nxp,pca9541.txt        |   6 +-
 drivers/i2c/muxes/Kconfig                          |   6 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 252 +++++++++++++++++=
----
 3 files changed, 218 insertions(+), 46 deletions(-)

--=20
2.11.0
