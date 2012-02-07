From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c/gpio-i2c add: add DT support
Date: Tue, 7 Feb 2012 03:56:24 +0100
Message-ID: <20120207025624.GB15647@game.jcrosoft.org>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <20120206160907.GG10173@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120206160907.GG10173-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 16:09 Mon 06 Feb     , Mark Brown wrote:
> On Sun, Feb 05, 2012 at 11:38:53AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > +	- udelay: half clock cycle time in us (may depend on each platform)
> 
> > +	udelay = <2>;		/* ~100 kHz */
> 
> Why not specify this in kHz and do the conversion in the driver?  It
> seems a more intuitive thing to be specifying.  I appreciate that the
> platform data used udelay but it seems an entirely unintuitive thing
> from a user point of view even if it's what the implementation wants.
because it's not accurate and on some platform you need to adapt it so we keep
the udelay

as example due to latency when changing state of the gpio as we may access it
via i2c or internal bus latency

Best Regards,
J.
