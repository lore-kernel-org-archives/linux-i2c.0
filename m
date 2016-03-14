From: "Swain, Peter" <Peter.Swain@caviumnetworks.com>
Subject: Re: [PATCH v3 05/14] i2c-octeon: Make adapter timeout tunable
Date: Mon, 14 Mar 2016 17:21:47 +0000
Message-ID: <BLUPR0701MB2067C09B7C009361EAE7B93B87880@BLUPR0701MB2067.namprd07.prod.outlook.com>
References: <cover.1457362545.git.jglauber@cavium.com>
 <00a182c50af211e409f128630ba6ba5359da6198.1457362545.git.jglauber@cavium.com>
 <20160312154611.GH1661@katana>,<20160314124505.GA5771@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0068.outbound.protection.outlook.com ([65.55.169.68]:1059
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751216AbcCNRg4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 13:36:56 -0400
In-Reply-To: <20160314124505.GA5771@hardcore>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <Jan.Glauber@caviumnetworks.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Daney, David" <David.Daney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>


Agreed, this timeout modparam can go, it serves no purpose which can't be achieved with existing ioctl.

It was introduced during debug to reduce spurious error count while hunting an issue finally resolved by the 80uS IFLG re-poll. But the same effect is achieved by (for example) the at24 driver's retry at 25mS timeout. The issue there is not timeout _within_ command, but failure to respect a 25mS post-write recovery time before next access to the at24, and the existing at24-level retry works well (though delaying the presentation of the next at24 transaction _within_ the at24 driver would have lead to less bus-level churn).
Leaving this adapter tuning out affects nothing but the (normally invisible) adapter-level retry count, which is better addressed within the target device's code, like at24 does. Default is ioctl-tweakable, so users wanting fine tuning have a mechanism.

-pete

________________________________________
From: Jan Glauber <jan.glauber@caviumnetworks.com>
Sent: Monday, March 14, 2016 5:45 AM
To: Wolfram Sang
Cc: linux-kernel@vger.kernel.org; linux-i2c@vger.kernel.org; Daney, David; Peter Swain
Subject: Re: [PATCH v3 05/14] i2c-octeon: Make adapter timeout tunable

On Sat, Mar 12, 2016 at 04:46:12PM +0100, Wolfram Sang wrote:
> On Mon, Mar 07, 2016 at 04:10:48PM +0100, Jan Glauber wrote:
> > From: Peter Swain <pswain@cavium.com>
> >
> > Make the i2c adapter timeout a module parameter to allow upper-level
> > target device drivers to retry with their own logic before their own
> > timeouts abort operations.
> >
> > For example, at24 eeprom driver retries for 25ms when -EAGAIN
> > indicates that an eeprom has gone unresponsive while committing
> > a newly written page (5ms on typical devices).
> >
> > Signed-off-by: Peter Swain <pswain@cavium.com>
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>
> i2c-dev has IOCTLs for timeout and retries. Can't you use those?
>

Yes, with these IOCTLs we don't need to add a module parameter
so I'll drop that.
