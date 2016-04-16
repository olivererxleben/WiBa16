classdef Apriori
    %APRIORI a monolithic Wrapper of the A-Priori-algorithm
    
    %   authors: Oliver Erxleben, Jens Overmöller
    %   The class is a monolithic wrapper around apriori rule
    %   mining algorithm. It implements three public methods: 
    %   - findFrequents: mines frequent item sets
    %   - findRules: mines association rules for frequent item sets
    %   - numThen: returns number of found when and then parts
    
    
    properties
       
       T; % Transaction data base
       M; % num cols of T
       N; % num rows of T
       minSup = 0.3;
       minConf = 0.6;
    end
      
    methods
             
        function this = Apriori(inputData, minSup, minConf)
            % Constructor function - creates a new Apriori Object 
            %   params: inputData: String Path to input data (required)
            %           
                        %minSup: double value of minimal threshold, defaults
            %           to 0.4
            %           
            %           minConf: double value of minimal confidence, 
            %           defaults to 0.7
            %           
            %           iterations: integer value of max iterations for 
            %           rule mining
            %
            %   return: a fresh Apriori object
            
            if (nargin == 0)
                error('At least an input is required');
            end
            
            if (nargin >= 1)
              this.T = dlmread(inputData);
              this.M = size(this.T,1);
              this.N = size(this.T,2);
              %this.frequents = cell(this.N);
              
            end
            
            if (nargin >= 2)
              this.minSup = minSup;
            end
            
            if (nargin >= 3)
              this.minConf = minConf;
            end
        end
    end
    
    methods (Access = public)
    
      function R = findRules(this) 
        % searches for association rules in the given db of transactions
        %   return: R set of rules
        %             R`s columns are of double size of columns of T: first
        %             half consists of when-parts, second half of then
        %             parts
        
        % 1. get frequent item sets
        L = this.findFrequent();

        % 2. find rules on the frequent sets, begin with biggest set and
        % iterate through one-elementers
        R = [];
        for i=size(L,1):-1:1
            R = [R; this.reg(L(i,:))];
        end 
        
      end
      
      function L = findFrequent(this)
        % calculates the set of frequent items from the given transaction db
        %   return: L: Matrix of frequent elements
        
        % 1. calc frequent elements of n = 1 (one-elementers)
        
        % noft = number of transaction, nofi = number of items
        [noft,nofi] = size(this.T); 
          
        L = zeros(1,nofi); % reserve some memory for results set
        t = 1; % counter for frequent elements
        
        % bit vector of frequent 1-element item sets
        L_one = sum(this.T) >= ceil(noft*this.minSup);
        
        % cancel criteria: no frequent 1 elementers  
        if( sum(L_one,2) == 0 )
          return;
        end
          
        % write frequents per line
        Lk = zeros(sum(L_one,2),nofi);
        for i=1:nofi
          if( L_one(1,i) == 1 )
            Lk(t,i) = 1;
            t = t+1;
          end 
        end
        L = Lk;
    
        % 2. calc k-elementers > 2
        for k=2:nofi
            
            % cancel criteria: no or just 1  (k-1)-elementers exist
            if( all(Lk == 0) | (size(Lk,1) < 2) )
                break;
            end 
            
            % find k-candidates for frequent sets via AprioriGen
            Ck = this.gen(Lk);
            
            % cancel criteria: no candidates
            if( isempty(Ck) )
                break;
            end 
            Lk = [];
 
            % find frequent sets in set of candidates
            [nofc,~] = size(Ck); % nofc = number of candidates
            for i=1:nofc
                
                % calc num of transactions i in candidates-set in T (db)
                a = this.count(Ck(i,:));
                
                % i is frequent? save it in result set
                if( a >= ceil(noft*this.minSup) )
                    Lk = [Lk; Ck(i,:)];
                    L = [L; Ck(i,:)];
                end 
            end 
        end
      end
      
      function  nR = numThen(this)
        nR = size(this.findRules(),2);
      end
      
      
    end
    
    
    
    methods (Access = private)
      
      function C = gen(this, L)
        % AprioGen Function
        %   params: L: Subset of Transactions
        %   return: C: set of k-elemters of frequent items
        
        % 0. Precomputing    
        [nofc,~]  = size(L);
        C = [];

        % 1. find k: Compute k with sum of L (k -1)
        k = sum(L,2)+1;
        
        % sizes of k and L are different? abort!
        if (~all( sum(L,2) == (k-1)))
          warning('AprioriGen ==> item sets are different! Aborting now');
          return;
        end 

        % 2. build k with two (k-1)-elementer sets
        for i=1:(nofc-1)
          for j = i:(nofc-1)
            z1 = L(i,:);
            z2 = L(j+1,:);
            % the last elements a different? Add it to the result set of
            % candidates
            if( this.beginIsEqual(z1,z2) )
                C = [C; or(z1,z2)];
            end
          end
        end    
      end
      
      function R = reg(this, Z)
        % AprioriReg function searches for association tules in the given 
        % set of transanctions  via a given set of
        % frequent items
        %   params: Z Häufige Itemmenge
        %   return: R set of found rules
        
        % 0. preperation
        R = [];
        RSupConf = [];
        D  = [];
        Dk = [];
        Y = [];
        nofi = size(Z,2);
        noft = size(this.T,1);
          
        % cancel when given frequent subset i one-elementers
        if (sum(Z,2) < 2)
          return;
        end
        
        % calculate support(Z)
        az = this.count(Z);
        supZ = az / noft;

        % 1. calc all 1 elementers of Z per row 
        for i=1:nofi
          
          if( Z(1,i) == 1)
              x = zeros(1,nofi);
              x(1,i) = 1;
              Y = [Y; x]; 
          end 
        end 

        % check confidence value for all 1-elementers with 
        % conf( Z/Y -> Y) = support(Z)/support(Z/Y)
        for i=1:size(Y,1)
        
          X = Z - Y(i,:); % = Z\Y
          ax = this.count(X);
          supX = ax / noft;
            
          if( az >= ceil(this.minConf*ax) )  
            % Matrix with Apriori IF
            Dk = [Dk; Y(i,:)];    
            RSupConf = [RSupConf; supZ, (supZ/supX)];
          end
        end 
          
        D = Dk;
        
        % 2. check confidence criteria for all k-elementers  
        for k=2:size(Z,2)
              
          % abort, if k-1 is empty
          if( isempty(Dk) )
            break;
          end
          
          
          % Setzte Kandidaten für Assoziationsregeln zusammen
          % build candidates for rules    
          Y = this.gen(Dk);    
          Dk = [];

          for i=1:size(Y,1)
                  
            X = Z - Y(i,:);
                  
            ax = this.count(X);
                  
            % is confidence (X->Y) >= minconf, save it as a rule
            if( az >= ceil(this.minConf*ax) )
                  
              Dk = [Dk; Y(i,:)];    
              RSupConf = [RSupConf; supZ, (supZ/supX)];
                  
            end 
              
          end
          
          
          % build the superset
          D = [D; Dk];
        end

        % build rules from the superset 
        % build when-parts from then-parts and union with supp&conf values
        for i=1:size(D,1)
           
          X = Z - D(i,1:nofi);   
          R = [R; X, D(i,:), RSupConf(i,:)];
          
        end    
      end
      
      function n = count(this, z)
        % helper function: returns number of occurences for every attr/item  
        n = sum((this.T*z') == sum(z)); 
      end
      
      function a = beginIsEqual(~, z1, z2)
        % helper function: checks whether 2 item sets of same size differ
        % at its last positions
        %   params: z1, z2 Zu vergleichende Itemmengen
        %   return: a 1 = Item-Mengen unterscheiden sich nur in beiden letzten Elementen 
        %             0 = Item-Mengen unterscheiden sich in mehr als nur beiden
        %             letzten Elementen
        
        k = sum(z1); 
        if(k==0) 
          a = 1;            
          return; 
        end
        
        s = min( find(z1,1,'last'), find(z2,1,'last') ) - 1; 
        if( sum( and(z1(1:s),z2(1:s)) ) == (k-1) )
          a = 1;
        else
          a = 0;
        end
      end  
    end
end

