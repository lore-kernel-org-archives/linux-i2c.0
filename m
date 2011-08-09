From: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2.6.38 1/1] scx200_acb.c: Add plain i2c (master_xfer / I2C_FUNC_I2C)
Date: Tue, 9 Aug 2011 14:51:53 -0600
Message-ID: <CAJfuBxxTPs0BhsOCdw_a2HmCaJwtTZj3kR+-3Tm=4zGp-EUoKA@mail.gmail.com>
References: <CAN=yz1iG02kqUm0pJ8sXgJ81JJerJTmWuGAkPo6UUGBTE_6Zpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN=yz1iG02kqUm0pJ8sXgJ81JJerJTmWuGAkPo6UUGBTE_6Zpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomas <tomasamot-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 8, 2011 at 1:29 PM, Tomas <tomasamot-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> From: Tomas Menzl <tomasamot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Add master_xfer / I2C_FUNC_I2C by simply reusing existing FSM
> scx200_acb_machine.
> This adds possibility to do direct read/write on an i2c device or use
> I2C_RDWR ioctl in addition to existing SM Bus API.
>
> Signed-off-by: Tomas Menzl <tomasamot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Hi Tomas,

I cannot properly test this, as the (baseline) module doesnt
initialize properly.
It fails thusly:
scx200_acb: NatSemi SCx200 ACCESS.bus Driver
scx200_acb: ACBCTL2 readback failed
scx200_acb: probe failed
scx200_acb: ACBCTL2 readback failed
scx200_acb: probe failed
root@voyage:~#

I presume Im lacking proper base values:
parm:           base:Base addresses for the ACCESS.bus controllers
(array of int)

voyage distro ships with these, but my impression is that theyre
for ALIX boxes, IIRC Tomas is using them.

scx200_acb base=0x810,0x820

Does anyone know the correct base for a Soekris net4801 ?

Im trying brute force right now, with the following script.

it avoids reserved ranges in /proc/ioport,
assuming other drivers wont claim things they arent using (correct ?)
and increments addresses by 2,
Id like to skip by 16, but fast and incomplete isnt reassuring.
Are there any rules/conventions regarding what starting-addresses are ?
(for this kind of device, or others)

Tomas, can you send me your /proc/ioports on your ALIX ?
Is the scx200_acb reservations in there ?

Also, I dont have a proper way to test for success of the probe,
the modprobe succeeds despite the probe failure.
So I have to just watch output.
Is there a sysfs file I could read (or check presence of)
to determine when the probe succeeds ?

Is there a way to tell installed module to re-probe with different addys,
perhaps with a uevent ??


#!/usr/bin/perl

use Data::Dumper;
$Data::Dumper::Sortkeys = 1; #sub { [sort {$a <=> $b} keys %$_] };

my $addr = 0;
my %reserved;

open(my $IO, "/proc/ioports") or die;
while (<$IO>) {
    s/^\s+//;
    my ($from,$to,@r) = split /[:-\s]/, $_;
    # print "$from,$to\n";
    printf "hex: %x,%x\n", hex($from), hex($to);
    $reserved{hex($from)} = hex($to);
}
print Dumper \%reserved;

$opt_x = 1;

while ($addr < 0x8000) {

    if ($reserved{$addr}) {
	print "skipping $addr\n";
	$addr = $reserved{$addr} + 1;
	print "skip to $addr\n";
	next;
    }

    printf "%x\n", $addr;
    $cmd = sprintf "modprobe scx200_acb base=0x%x\n", $addr;

    if ($opt_x) {
	print `rmmod scx200_acb`;
	print $cmd;
	$resp = `$cmd`;

	# modprobe succeeds despite addr-probe failure
	# need ok way to test..
    }

    $addr += 2; # bloody small steps16;
    $addr++ if $addr % 2;
}
