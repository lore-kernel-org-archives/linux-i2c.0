From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] i2c: remove use of in_atomic()
Date: Mon, 1 Apr 2019 13:21:09 +0200
Message-ID: <20190401112109.GB12232@hirez.programming.kicks-ass.net>
References: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
 <20190401104756.GK11158@hirez.programming.kicks-ass.net>
 <20190401111323.ajvo4drongc6dtel@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401111323.ajvo4drongc6dtel@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 01, 2019 at 01:13:24PM +0200, Wolfram Sang wrote:

> > Why must we allow i2c usage with IRQs disabled? Just say NO?
>=20
> I'd love to. But quoting my patch description:
>=20
> "This matches the use cases for atomic I2C transfers I have seen so far:
> very late communication (mostly to a PMIC) to powerdown or reboot the
> system."

Ah, sorry, I missed that.

> And yes, I would never recommend a HW design to use I2C for shutting
> down/rebooting. But such HW is out there.

Can we then make the whole thing conditional on:

  system_state > SYSTEM_RUNNING

Such that we're sure to never trigger this under any other conditions?
