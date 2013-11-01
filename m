From: srinivas kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Fri, 1 Nov 2013 12:50:25 +0000
Message-ID: <5273A391.5000302@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>  <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>  <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>  <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>  <525FF498.3060202@st.com> <1382021369.4093.44.camel@weser.hi.pengutronix.de> <5260EFDC.804@st.com> <526E7C8C.8080603@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526E7C8C.8080603-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 28/10/13 15:02, Maxime Coquelin wrote:
>>
>> 6> IMHO, the compatible string should be "vendor,<IP-name>-<IP-version>"
>> rather than first SoC.
> I agree.
> In this case, we add support to revision 4 of SSC IP.
Its not the revision its name of the new IP which is SSC4. However  this
driver is also compatible with old SSC IP, so It would be nice to have
something like two compatible strings "st,comms-ssc-i2c" and
"st,comms-ssc4-i2c"

Thanks,
srini
> 
> Is "st,comms-ssc-v4" okay?
