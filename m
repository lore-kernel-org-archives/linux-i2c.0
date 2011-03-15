From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on
 omapl138 (logic pd som)
Date: Tue, 15 Mar 2011 13:09:58 -0400
Message-ID: <AANLkTi=opkM3WW2v3xV=ox9HwD__WjqQuh3sM6Vh7fLj@mail.gmail.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Spoke too soon.

On Tue, Mar 15, 2011 at 1:02 PM, Ben Gardiner
<bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org> wrote:
> [...]
> When I revert:
> c5b4afec8e669bbe265daea24037fccfc42c4fe3 i2c-davinci: Fix TX setup for more SoCs
> 4bba0fd8d1c6d405df666e2573e1a1f917098be0 i2c-davinci: Fix race when
> setting up for TX

It just took longer than usual for the onset of the messages; my
console is now filling with

[...]
pca953x 1-0021: failed reading register
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
pca953x 1-0021: failed reading register
i2c_davinci i2c_davinci.1: controller timed out
i2c_davinci i2c_davinci.1: initiating i2c bus recovery
[...]

as before.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
