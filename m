From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: 2.6.30-rc3 i2c build warnings
Date: Fri, 24 Apr 2009 12:45:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904241243270.10096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Sm2mNEVzN6xvc1dOI9j9zw)"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Sm2mNEVzN6xvc1dOI9j9zw)
Content-type: TEXT/PLAIN; charset=ISO-8859-7
Content-transfer-encoding: 8BIT

drivers/i2c/i2c-core.c:312: warning: ¡client_unregister¢ is deprecated 
(declared at include/linux/i2c.h:357)
drivers/i2c/i2c-core.c:313: warning: ¡client_unregister¢ is deprecated 
(declared at include/linux/i2c.h:357)
drivers/i2c/i2c-core.c:653: warning: ¡detach_client¢ is deprecated 
(declared at include/linux/i2c.h:154)
drivers/i2c/i2c-core.c:719: warning: ¡detach_client¢ is deprecated 
(declared at include/linux/i2c.h:154)
drivers/i2c/i2c-core.c:788: warning: ¡detach_client¢ is deprecated 
(declared at include/linux/i2c.h:154)
drivers/i2c/i2c-core.c:869: warning: ¡client_register¢ is deprecated 
(declared at include/linux/i2c.h:356)
drivers/i2c/i2c-core.c:870: warning: ¡client_register¢ is deprecated 
(declared at include/linux/i2c.h:356)
drivers/i2c/i2c-core.c:884: warning: ¡i2c_attach_client¢ is deprecated 
(declared at drivers/i2c/i2c-core.c:835)
drivers/i2c/i2c-core.c:884: warning: ¡i2c_attach_client¢ is deprecated 
(declared at drivers/i2c/i2c-core.c:835)
drivers/i2c/i2c-core.c:891: warning: ¡client_unregister¢ is deprecated 
(declared at include/linux/i2c.h:357)
drivers/i2c/i2c-core.c:892: warning: ¡client_unregister¢ is deprecated 
(declared at include/linux/i2c.h:357)
drivers/i2c/i2c-core.c:912: warning: ¡i2c_detach_client¢ is deprecated 
(declared at drivers/i2c/i2c-core.c:887)
drivers/i2c/i2c-core.c:912: warning: ¡i2c_detach_client¢ is deprecated 
(declared at drivers/i2c/i2c-core.c:887)


thanks,
Len Brown, Intel Open Source Technology Center

--Boundary_(ID_Sm2mNEVzN6xvc1dOI9j9zw)--
