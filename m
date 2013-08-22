From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: Re: passing two interrupts two an I2C driver
Date: Thu, 22 Aug 2013 10:23:28 +0100
Message-ID: <1377163408.10707.29.camel@hornet>
References: <520E3B8F.9010800@samsung.com> <520E7417.3090606@wwwdotorg.org>
	 <20130819084227.GC3719@e106331-lin.cambridge.arm.com>
	 <5214AA52.2060209@samsung.com> <1377088624.10707.23.camel@hornet>
	 <20130821175446.GI26118@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130821175446.GI26118-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <l.czerwinski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2013-08-21 at 18:54 +0100, Mark Brown wrote:
> On Wed, Aug 21, 2013 at 01:37:04PM +0100, Pawel Moll wrote:
> 
> > So let me ask such question... If Device Tree didn't exist, how would
> > you make drive such device? I guess it would require some custom code,
> 
> It's always done using platform data, same for SPI - if we update one we
> should probably update both.

If the platform data used to carry the (custom) irq data, the DT-powered
driver could interrogate the DT on is own, couldn't it? Of course there
should be some helper available, maybe something of that sort? (warning,
untested)

8<---------------------
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1264923..d2a02dd 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -46,6 +46,15 @@ unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
+unsigned int irq_of_parse_and_map_by_name(struct device_node *dev,
+		const char *name)
+{
+	int index = of_property_match_string(dev, "interrupt-names", name);
+
+	return index < 0 ? 0 : irq_of_parse_and_map(dev, index);
+}
+EXPORT_SYMBOL_GPL(irq_of_parse_and_map_by_name);
+
 /**
  * of_irq_find_parent - Given a device node, find its interrupt parent node
  * @child: pointer to device node
8<---------------------

Pawel
