From: Peter Korsgaard <peter.korsgaard@barco.com>
Subject: Re: I2c-ocore linux driver debug
Date: Wed, 14 Jan 2009 16:51:05 +0100
Message-ID: <87zlhtrimu.fsf@thor.barco.com>
References: <ce62e9d00901130200v19a57684u69ed8cfbd1085085@mail.gmail.com>
Reply-To: Discussion list about free open source IP cores <cores@opencores.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cores-bounces@opencores.org>
In-Reply-To: <ce62e9d00901130200v19a57684u69ed8cfbd1085085@mail.gmail.com>
	(Fabien Marteau's message of "Tue\, 13 Jan 2009 11\:00\:10 +0100")
List-Unsubscribe: <http://www.opencores.org/mailman/listinfo/cores>,
	<mailto:cores-request@opencores.org?subject=unsubscribe>
List-Archive: <http://www.opencores.org/forums.cgi/cores>
List-Post: <mailto:cores@opencores.org>
List-Help: <mailto:cores-request@opencores.org?subject=help>
List-Subscribe: <http://www.opencores.org/mailman/listinfo/cores>,
	<mailto:cores-request@opencores.org?subject=subscribe>
Sender: cores-bounces@opencores.org
Errors-To: cores-bounces@opencores.org
To: Discussion list about free open source IP cores <cores@opencores.org>, linux-i2c@vger.kernel.org, lepingouin.tux@gmail.com
List-Id: linux-i2c@vger.kernel.org

>>>>> "FM" == Fabien Marteau <lepingouin.tux@gmail.com> writes:

Hi,

Discussions about the Linux i2c drivers belongs on the
linux-i2c@vger.kernel.org list, let's move discussion there.

FM> I integrated the IP i2c ocore for my platform ARMadeus apf9328
FM> (http://www.armadeus.com/wiki).  ARMadeus platform is an embedded
FM> system with a processor i.MXL and a FPGA Spartan3.

FM> The interface between the processor and FPGA is a 16bits data bus,
FM> and it's wired to do only 16bits read/write. Thus, I had to write
FM> a wrapper to convert 8bits ocore interface in 16bits
FM> interface. This wrapper mutiplex data bus to keep data in low part
FM> of the 16bits bus (see attachement) and add an ID register to
FM> unsure driver that the component is configured correctly.

FM> I had two problems with the driver:
FM> * Registers addresses.
FM> * To send stop command, driver have to set stop bit *before*
FM> sending the last byte. In the driver, this stop bit is set at the
FM> end of command, and that doesn't work.

FM> I was really surprised of this bugs, because this IP is old and I
FM> feel I am the only one that have these problems. Maybe the problem
FM> come from wrapper but I don't know why.

FM> I modified the driver to fix these bugs (see diff in attachment), and that
FM> work well with two components (LIS3LV02DL accelerometer and DS28CZ04 EEPROM)
FM> and testbench provided in attachment.

FM> Addresses registers problem
FM> ===========================

FM> The original driver give these addresses:
FM> /* registers */
FM> #define OCI2C_PRELOW		0
FM> #define OCI2C_PREHIGH		1
FM> #define OCI2C_CONTROL		2
FM> #define OCI2C_DATA		3
FM> #define OCI2C_CMD		4 /* write only */
FM> #define OCI2C_STATUS		4 /* read only, same address as OCI2C_CMD */

That fits the specs (i2c_specs.pdf, by Richard Herveille)

FM> After lot of tests, I found that this addresses work better:
FM> /* registers */
FM> #define OCI2C_PRELOW		0
FM> #define OCI2C_PREHIGH		1
FM> #define OCI2C_CONTROL		2
FM> #define OCI2C_CMD			4
FM> #define OCI2C_DATA_TXR		5
FM> #define OCI2C_STATUS		6
FM> #define OCI2C_DATA_RXR		7

Strange, seems like something went wrong in your wrapper.

FM> Stop command
FM> ============

FM> The most important problem I had was the stop command. To send a command like
FM> write quick SMBus (see Documentation/i2c/smbus-protocol) :

FM> S Addr [Rd/Wr] P

FM> The stop bit must be set at the same time that start bit. To do
FM> that I modified
FM> the xfer function:
FM> 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
FM> by:
FM> 	if(i2c->msg->len == 0)
FM> 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START|OCI2C_CMD_STOP);
FM> 	else
FM> 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);

It could be that we have a problem with zero length transfers (don't
have access to any smbus devices) - Could you please send a proper
patch in diff -urpN format?

-- 
Bye, Peter Korsgaard
