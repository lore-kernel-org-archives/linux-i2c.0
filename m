From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Date: Fri, 9 Oct 2009 10:13:58 -0600
Message-ID: <fa686aa40910090913p719ef4cdqe480ae01bd4ab6c8@mail.gmail.com>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
	<1255095793.16018.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1255095793.16018.32.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Nate Case <ncase@xes-inc.com>
Cc: devicetree-discuss@ozlabs.org, linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 9, 2009 at 7:43 AM, Nate Case <ncase@xes-inc.com> wrote:
> On Fri, 2009-10-09 at 07:14 +0200, Wolfram Sang wrote:
>> And while doing this and figuring the pro/cons of those methods, I
>> stumbled over this commit:
>>
>> =A0 =A0 =A0 =A0 gpio: pca953x: Get platform_data from OpenFirmware
>> =A0 =A0 =A0 =A0 (1965d30356c1c65660ba3330927671cfe81acdd5)
>
> Aside from any issues you have with the properties themselves, what's
> your take on this approach?

As I mentioned in an earlier email, I don't think quite the right form
has been found yet, but I like the direction things are moving.

> Personally, I just got tired of waiting for someone else to solve the
> pdata/OF problem. =A0So I submitted that commit as an attempt at something
> very simple and unobtrusive to the device driver itself. =A0It seems
> pretty clean to me, but I'm curious to see if others have any better
> ideas.

Yup, that's good.  Between Anton's, Wolfram's and your work things are
going the right way.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
