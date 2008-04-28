From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: i2c or eeprom enumeration problem
Date: Mon, 28 Apr 2008 05:05:15 -0700
Message-ID: <20080428050515.fcc05689.akpm@linux-foundation.org>
References: <4815509A.9040802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933883AbYD1MGk@vger.kernel.org>
In-Reply-To: <4815509A.9040802@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 27 Apr 2008 21:20:42 -0700 Ulrich Drepper <drepper@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On a NUMA system the eeprom interface in /sys
> 
>   /sys/bus/i2c/drivers/eeprom/*
> 
> do not list all the DRAM eeproms.  Only the DRAM from one node is
> listed.  I have a 4 socket system with all 16 banks filled and see only
> 4 entries.
> 
> My suspicion (without looking at any code) is that the list of i2c
> devices with eeproms is collected once and this happens only on one CPU.
>  I sees not to be dynamic since when I read the files with taskset
> restricting execution on certain sockets and cores the result doesn't
> change.
> 
> Is this known or expected (I hope not the latter)?  Where should I look
> at?  I assume that's in the i2c code?
> 

Let's cc the i2c list.
