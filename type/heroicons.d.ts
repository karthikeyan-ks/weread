declare module '@heroicons/react/outline' {
    import * as React from 'react';
    
    export interface IconProps extends React.SVGProps<SVGSVGElement> {
      title?: string;
      titleId?: string;
    }
  
    export const AcademicCapIcon: React.FC<IconProps>;
    export const AdjustmentsIcon: React.FC<IconProps>;
    // Add other icons as needed
  }
  