From: Dan Priamo <danp@adiengineering.com>
Subject: RE: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Tue, 29 Aug 2017 20:10:48 +0000
Message-ID: <VI1PR0401MB2303FCB4B465FC147AC55A71BB9F0@VI1PR0401MB2303.eurprd04.prod.outlook.com>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
 <20170814193105.cosdlbf5gypazlzn@ninjato>
 <f1d1d452-892a-82ff-c6a2-1e2512d9ed70@adiengineering.com>
 <20170829102225.7yjh52hivygbdbc7@ninjato>
 <20170829113558.GA5406@hmswarspite.think-freely.org>
 <20170829114933.7ymoci5snjicuvuu@ninjato>
 <VI1PR0401MB23035B5367515C92CA6820E7BB9F0@VI1PR0401MB2303.eurprd04.prod.outlook.com>
 <20170829200830.op73cdkwjmhrht3k@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829200830.op73cdkwjmhrht3k@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Neil Horman <nhorman@tuxdriver.com>, Steve Douthit <stephend@adiengineering.com>, "seth.heasley@intel.com" <seth.heasley@intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Thank you!

-----Original Message-----
From: Wolfram Sang [mailto:wsa@the-dreams.de]=20
Sent: Tuesday, August 29, 2017 4:09 PM
To: Dan Priamo <danp@adiengineering.com>
Cc: Neil Horman <nhorman@tuxdriver.com>; Steve Douthit <stephend@adienginee=
ring.com>; seth.heasley@intel.com; linux-i2c@vger.kernel.org; linux-kernel@=
vger.kernel.org
Subject: Re: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block rea=
ds

> We are using Linux stable kernel version 4.4.y and would like to see=20
> these changes included in that version. So once these patches are=20
> merged in, can they be tagged for other Linux stable kernel releases=20
> to pick up these changes?

Okay, since I haven't pushed out yet, I can re-apply the bugfix to for-curr=
ent and add the stable tag to it.
