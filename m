From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v3 0/3] i2c-mpc: add support for the Freescale MPC512x and
	other fixes
Date: Tue, 26 Jan 2010 20:28:12 +0100
Message-ID: <1264534095-20777-1-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

This patch series adds support for the MPC512x from Freescale to the
i2c-mpc driver. At that occasion, issues with  __devinit[data] have
been fixed and the doc of the FSL I2C dts bindings updated. It has
been tested on a MPC5121ADS, TQM5200 and TQM8560 board

Changes since v1:

- use macro MPC_I2C_CLOCK_PRESERVE/SAFE for the special clock settings.
- document the special DTS node "fsl,mpc5121-i2c-ctrl".
- update and correct the Kconfig help.
- some other minor fixes as suggested by Wolfram.

Changes since v2:

- use __init[data] instead of __devinit[data] for this driver.

Wolfgang

Wolfgang Grandegger (3):
  i2c-mpc: use __init[data] for initialization functions and data
  i2c-mpc: add support for the MPC512x processors from Freescale
  powerpc: doc/dts-bindings: update doc of FSL I2C bindings

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++-
 drivers/i2c/busses/Kconfig                     |    7 +-
 drivers/i2c/busses/i2c-mpc.c                   |  197 +++++++++++++++---------
 3 files changed, 150 insertions(+), 84 deletions(-)
