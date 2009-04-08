From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 5/5] powerpc/85xx: i2c-mpc: use new I2C bindings for
	the Socates board
Date: Wed, 08 Apr 2009 09:16:29 +0200
Message-ID: <49DC4F4D.10803@grandegger.com>
References: <20090407082052.477328750@denx.de>
	<20090407082231.803193635@denx.de>
	<fa686aa40904070843q248f3ae1l9c8ca0d5a65c8cc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <fa686aa40904070843q248f3ae1l9c8ca0d5a65c8cc3@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Tue, Apr 7, 2009 at 1:20 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Preserve I2C clock settings for the Socrates MPC8544 board.
> 
> I had thought that the preserve-clocking property was intended for
> older boards that don't currently have any method of getting the clock
> setting out of u-boot.  Since Socrates is a new board, U-Boot should
> probably be made to fill in the real clock rate setting.

I'm not sure if I understand what you mean. If an old version of U-Boot
on an old board sets the I2C clock, it can be used (inherited) by Linux
using the property "preserve-clocking".

It is actually the customers choice to set the I2C clock in U-Boot and
re-use it by Linux.

Wolfgang.
