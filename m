From: Martin Ayotte <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/3] dts: sun8i-h3: add missing UARTs pins
 and I2C entries for AllWinner H3
Date: Thu, 5 May 2016 10:06:12 -0400
Message-ID: <cover.1462457172.git.martinayotte@gmail.com>
Reply-To: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDW4XUV4YULRBH5KVW4QKGQESN2ACII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This patch is submit to provide endusers access to additional UARTs on
AllWinner H3 SoC along with I2C ports.

Regards,
Martin.

(Note: please ignore yesterday's v3, since the cover-letter had a wrong 
Message-Id, and the [1/3] patch wwas missing)

Martin Ayotte (3):
  add uart1/uart2/uart3 pins definitions
  add i2c0/i2c1/i2c2 pins definitions
  add i2c0/i2c1/i2c2 soc peripherals

 arch/arm/boot/dts/sun8i-h3.dtsi | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

-- 
2.7.4
