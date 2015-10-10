From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/6] i2c: designware: Remove interrupt clearing from
 i2c_dw_pci_probe()
Date: Sat, 10 Oct 2015 08:53:38 +0100
Message-ID: <20151010075337.GE1619@katana>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1441031493-18938-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57325 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbbJJHxu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 10 Oct 2015 03:53:50 -0400
Content-Disposition: inline
In-Reply-To: <1441031493-18938-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 05:31:28PM +0300, Jarkko Nikula wrote:
> There is no need to clear interrupts in i2c_dw_pci_probe() since only place
> where interrupts are unmasked is i2c_dw_xfer_init() and there interrupts
> are always cleared after commit 2a2d95e9d6d2 ("i2c: designware: always
> clear interrupts before enabling them").

Still, their status might be unclear when we init because firmware might
have used it before. It should be easy to reintroduce this in patch 6,
or?


--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGMQBAAoJEBQN5MwUoCm2ts0P/RPUQeulIcpmg1f4tQ+7sMuK
N+KiAV+nUYlFjzeKqqXjBTrMa2wKuC0vR4SFP9OiKJEfr70lIVM1SFpXnNPAhUZb
sqJz1uzxc9dLRnZB+hxbEhyOBfIU2xzFBs8PZpAucKnTCeMfwNa8OWzKqyzTw+M3
aw46a7/QB/44z+lIEfJuddMymDF4qYIJQqQNDG7qjvpvtqrJi5kAvfgK17TM/ivP
JxNVaWU85giL58vRS74u6GfL9I+ieK2ic+w8vWnWy1sTp8QuxX13l4r6Vjj2+ZmN
EPaVj9U3WV0yPvBYLTAlQlyVkZycrTEvSZg0eSX1Oz672e485F90KrFAi3JuZxXT
NYmCoPhuLzDK31MalHtgHj8PGiG7H/+NJRvatcpZkMJpCbVx4Iz9McIBuOMGOetZ
4Flo/ooSm3l0iZi2Mdp3mdMzBzy3xv7aXSsWEC25V2nv9jAOAHMnquL/iuQhlVBA
Z8JveFkOPm8UIYN+LuOMkBlOwVC3K4+rQAvQ/YiBWahUtJfz/xaFGHyzwRPtY1EZ
l6bROzNsvJAxnDirdB3q5N7hVvdb3rS4WAqthybhKr2t9rSH6FkZEgDViCj48JVl
AUuCRlc79QI3AiICod4BEIAvSrB5f6ziANn9SiPCg4BJFS2Ne79kAHXxhOAD+HRD
W0v56o00txPNPtSpr+WW
=OyXK
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
